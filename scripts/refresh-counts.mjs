#!/usr/bin/env node
/**
 * refresh-counts.mjs - the counts refresher for this Company OS.
 *
 * Zero dependencies and no install step. Tested on Node 22, and it uses nothing
 * newer than the Node 18 standard library. Run it from anywhere: it resolves the
 * repo root from its own location and prints the root it resolved, rather than
 * assuming the directory you happen to be standing in.
 *
 *   node scripts/refresh-counts.mjs            print what this script owns and what it does not
 *   node scripts/refresh-counts.mjs --write    measure disk, rewrite the numbers inside anchors
 *   node scripts/refresh-counts.mjs --check    read only, fail loudly and name every problem
 *
 *
 * WHY THIS EXISTS
 *
 * A number typed by hand into a context file is true on the day it is written and
 * lying within a month, and nothing about it looks wrong in the meantime. The store
 * this kit is modelled on hit that all at once: a context file claiming 5 fewer
 * skills than existed on disk, 1 fewer agent, and "5 rules" in prose sitting
 * immediately above a 7-row table of rules, while the catalog carried three
 * different totals for the same quantity in a single file. Nothing errored and
 * nothing broke. Every agent reading those files simply worked from a confident
 * wrong number, and the humans stopped opening the catalog because it had been
 * wrong once.
 *
 *
 * THE OWNERSHIP LINE
 *
 * COUNTS ARE MECHANICAL, so this script owns them and rewrites them silently.
 * CATEGORISATION IS JUDGMENT, so this script never performs it. When it finds a
 * file on disk that the catalog does not mention, it reports the orphan, names the
 * headings it could be filed under, and fails.
 *
 * The reason is worth keeping in the file, because the next person to read it will
 * want to automate the other half. A script that guessed a category would file
 * things wrong quietly, which is worse than a loud failure, because a catalog that
 * is quietly wrong stops being read at all. Automating the mechanical half is what
 * buys the credibility to hard-fail on the judgment half.
 *
 *
 * ANCHORS ARE THE OWNERSHIP CONTRACT
 *
 * This script rewrites a number by matching a named anchor, so the anchor is the
 * only thing that makes a number owned:
 *
 *     <!-- counts:skills -->5<!-- /counts:skills -->
 *
 * Anything outside an anchor rots, and it rots while the check reports that
 * everything is current. In the source store the anchored section headers were
 * exact while an unanchored tree 50 lines above them, in the same file, was wrong
 * by 7 skills, 1 agent, 2 rules and several dozen wiki pages. The check passed.
 *
 * So the rule for a new number is: name the anchor, or do not write the number.
 * No exceptions, including for a number you are certain will never change.
 *
 * The digit goes inside the anchor and the noun stays outside it, because the
 * anchor body is replaced wholesale on every run. Write this:
 *
 *     <!-- counts:skills -->5<!-- /counts:skills --> skills
 *
 * and not `<!-- counts:skills -->5 skills<!-- /counts:skills -->`, which loses the
 * word the first time the count changes.
 *
 *
 * THE ANCHOR-COVERAGE SCAN, AND WHY IT IS HERE
 *
 * The source store never audited its own anchor coverage, which is what let the
 * passing check endorse a wrong tree. This script closes that gap: it scans the
 * root context files for a bare digit in front of a noun it owns, and fails when
 * it finds one outside an anchor. An automated check that does not enumerate its
 * own coverage converts an obvious error, which a human might have noticed, into
 * an invisible one that a green check endorses.
 *
 * The scan needs an escape hatch or it becomes a false-positive machine, and a
 * gate with false positives is switched off within a week, at which point it
 * protects nothing. The hatch is required and explicit, never implicit:
 *
 *     <!-- counts:ignore -->3 rules<!-- /counts:ignore -->  (and say why, in the text)
 *
 * Having to type the marker is the point. It costs two seconds, it forces the
 * judgment call, and it leaves the decision visible in the diff.
 *
 *
 * THE NAMED EXEMPTIONS
 *
 * A few files in the counted directories are furniture rather than content: a root
 * describing itself, a directory README, a test harness sitting beside the hook it
 * exercises. None is counted as an item and none needs a catalog entry. They are
 * listed by exact path in EXEMPT rather than matched by pattern, so the list stays
 * short and every entry has to be argued for. A pattern exemption grows quietly
 * and eventually swallows a real item; a named one shows up in a diff.
 *
 *
 * WHAT THIS SCRIPT STRUCTURALLY CANNOT CATCH
 *
 * - Spelled-out numbers. "five skills" evades the coverage scan entirely. Write
 *   counts as digits, inside anchors.
 * - A wrong description, a wrong routing phrase or a miscategorised file. Those
 *   are judgment, and judgment fails loudly here rather than being guessed at.
 * - Numbers in files below the repo root. Only the root context files are scanned,
 *   because those are the files that make claims about the store as a whole.
 * - Drift arriving through a path the review gate never sees. That is what the
 *   push trigger in .github/workflows/check-counts.yml is for.
 */

import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const ROOT = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');

// The five content roots. Counted so that a sixth root shows up as a changed
// number in a diff rather than as a thing nobody noticed.
const CONTENT_ROOTS = ['.claude', 'company-wiki', 'clients', 'raw', 'archive'];

// The catalog. One file, so there is one list in the store.
const CATALOG = 'INDEX.md';

// Named exemptions. Each of these is furniture rather than content, so none is
// counted as an item and none needs a catalog entry:
//   company-wiki/guide.md      every content root carries a guide describing itself,
//                              so this one file is allowed at the wiki root
//   .claude/hooks/safety-guard-test.sh
//                              the guard's own test harness. It lives beside the hook
//                              on purpose, so that a change to one is visibly a change
//                              to the other, but it is never wired to a lifecycle event
// Listed by exact path rather than pattern-matched, because an exemption you cannot
// read off the file is one nobody can audit later. Add to this list only when you
// can say in one line why the file is furniture.
//
// The commands guide used to be a third entry, as .claude/commands/README.md. It
// moved to .claude/commands-guide.md instead, because an exemption that makes the
// count disagree with what the loader loads is buying the wrong thing: the loader
// discovered seven commands while every count in the store said six. Furniture
// belongs outside the discovered tree, not inside it with a note.
const EXEMPT = [
  'company-wiki/guide.md',
  '.claude/hooks/safety-guard-test.sh',
];

// Paths cited in prose that are deliberately absent from a fresh clone. Each one
// has to be argued for in a line, same as EXEMPT, because the alternative is a
// dangling-path check with false positives, and a check with false positives is
// switched off inside a week.
//   .claude/safety-roster   gitignored on purpose. Who is trusted is a per-machine
//                           decision, so the example ships and the real file does not.
const ABSENT_BY_DESIGN = ['.claude/safety-roster'];

// Nouns whose bare digits must live inside an anchor. Kept deliberately short:
// every entry here is a phrase this script can measure from disk. "workflows" is
// absent on purpose, because it collides with the /workflows commands and with
// ordinary prose, and a collision would produce the false positives that get a
// check disabled.
// One optional word is allowed between the digit and the noun, so that "5 starter
// skills" is caught rather than waved through. That widening has a known false
// positive on compound nouns: "12 hook formulas" reads as a hook count and gets
// flagged. That is what the counts:ignore hatch is for, and two seconds of typing
// is the right price for a scan that catches the real thing.
const OWNED_NOUNS = [
  [/\b\d+\s+(?:[a-z]+\s+)?skills?\b/gi, 'skills'],
  [/\b\d+\s+(?:[a-z]+\s+)?rules?\b/gi, 'rules'],
  [/\b\d+\s+(?:[a-z]+\s+)?hooks?\b/gi, 'hooks'],
  [/\b\d+\s+(?:[a-z]+\s+)?commands?\b/gi, 'commands'],
  [/\b\d+\s+(?:[a-z]+\s+)?agents?\b/gi, 'agents'],
  [/\b\d+\s+(?:[a-z]+\s+)?content\s+roots?\b/gi, 'roots'],
  [/\b\d+\s+(?:[a-z]+\s+)?client\s+folders?\b/gi, 'clients'],
  [/\b\d+\s+(?:[a-z]+\s+)?wiki\s+pages?\b/gi, 'wiki'],
];

const ANCHOR_RE =
  /(<!--\s*counts:([a-z0-9][a-z0-9:_-]*)\s*-->)([\s\S]*?)(<!--\s*\/counts:\2\s*-->)/g;

// ---------------------------------------------------------------------------
// Disk readers
// ---------------------------------------------------------------------------

const abs = (rel) => path.join(ROOT, rel);
const isDir = (rel) => fs.existsSync(abs(rel)) && fs.statSync(abs(rel)).isDirectory();

function entries(rel) {
  if (!isDir(rel)) return [];
  return fs
    .readdirSync(abs(rel), { withFileTypes: true })
    .filter((e) => !e.name.startsWith('.'))
    .sort((a, b) => a.name.localeCompare(b.name));
}

const subdirs = (rel) => entries(rel).filter((e) => e.isDirectory()).map((e) => e.name);

const filesIn = (rel, exts) =>
  entries(rel)
    .filter((e) => e.isFile() && exts.includes(path.extname(e.name)))
    .map((e) => `${rel}/${e.name}`);

function walk(rel, ext, out = []) {
  for (const e of entries(rel)) {
    const child = `${rel}/${e.name}`;
    if (e.isDirectory()) walk(child, ext, out);
    else if (path.extname(e.name) === ext) out.push(child);
  }
  return out;
}

/**
 * Measure everything mechanical. Every key here becomes a valid anchor name, and
 * an anchor name that is not a key here is an orphan.
 */
function measure() {
  const skills = subdirs('.claude/skills').filter((n) =>
    fs.existsSync(abs(`.claude/skills/${n}/SKILL.md`)),
  );
  const wikiFolders = subdirs('company-wiki');

  const items = {
    skills: skills.map((n) => `.claude/skills/${n}/SKILL.md`),
    rules: filesIn('.claude/rules', ['.md']).filter((p) => !EXEMPT.includes(p)),
    hooks: filesIn('.claude/hooks', ['.sh']).filter((p) => !EXEMPT.includes(p)),
    commands: walk('.claude/commands', '.md').filter((p) => !EXEMPT.includes(p)),
    agents: filesIn('.claude/agents', ['.md']).filter((p) => !EXEMPT.includes(p)),
    wiki: walk('company-wiki', '.md').filter((p) => !EXEMPT.includes(p)),
  };

  const owned = {
    skills: { value: items.skills.length, source: '.claude/skills/*/SKILL.md' },
    rules: { value: items.rules.length, source: '.claude/rules/*.md' },
    hooks: { value: items.hooks.length, source: '.claude/hooks/*.sh' },
    commands: { value: items.commands.length, source: '.claude/commands/**/*.md' },
    agents: { value: items.agents.length, source: '.claude/agents/*.md' },
    roots: {
      value: CONTENT_ROOTS.filter((r) => isDir(r)).length,
      source: `top-level roots present, of ${CONTENT_ROOTS.join(', ')}`,
    },
    clients: { value: subdirs('clients').length, source: 'clients/*/' },
    wiki: { value: items.wiki.length, source: 'company-wiki/**/*.md' },
    'raw-buckets': { value: subdirs('raw').length, source: 'raw/*/' },
    'ci-workflows': {
      value: filesIn('.github/workflows', ['.yml', '.yaml']).length,
      source: '.github/workflows/*.yml',
    },
  };

  for (const folder of wikiFolders) {
    owned[`wiki:${folder}`] = {
      value: walk(`company-wiki/${folder}`, '.md').length,
      source: `company-wiki/${folder}/**/*.md`,
    };
  }

  return { owned, items, wikiFolders };
}

// The root context files are the ones that describe the store, so they are the
// ones whose numbers have to be owned. Discovered rather than listed, so a new
// root file (AGENTS.md, MEMORY.md) is covered the day it lands.
const targetFiles = () =>
  entries('.')
    .filter((e) => e.isFile() && path.extname(e.name) === '.md')
    .map((e) => e.name);

// ---------------------------------------------------------------------------
// Anchors
// ---------------------------------------------------------------------------

const lineOf = (text, index) => text.slice(0, index).split('\n').length;

function readAnchors(text) {
  const found = [];
  ANCHOR_RE.lastIndex = 0;
  let m;
  while ((m = ANCHOR_RE.exec(text)) !== null) {
    found.push({ key: m[2], body: m[3], line: lineOf(text, m.index), at: m.index });
  }
  return found;
}

/**
 * Where every HTML comment in the file actually starts, paired left to right.
 *
 * HTML comments do not nest. Put an anchor inside an explanatory comment block and
 * the first closing marker ends the block, so the rest of the explanation renders
 * as body text on the page. Nothing errors and the counts still refresh correctly,
 * which is what makes it worth a check: the file is wrong in the one place nobody
 * looks, the rendered view.
 */
function commentStarts(text) {
  const starts = new Set();
  let i = 0;
  while (i < text.length) {
    const open = text.indexOf('<!--', i);
    if (open === -1) break;
    starts.add(open);
    const close = text.indexOf('-->', open + 4);
    if (close === -1) break;
    i = close + 3;
  }
  return starts;
}

/** Blank out every anchored span so the coverage scan only sees unowned text. */
function maskAnchors(text) {
  ANCHOR_RE.lastIndex = 0;
  return text.replace(ANCHOR_RE, (full) => full.replace(/[^\n]/g, ' '));
}

/**
 * Blank out fenced code blocks, line count preserved.
 *
 * The path-integrity scan runs over prose, and a fenced block is where the
 * examples live: a line-format demonstration, a shell snippet, an anchor whose
 * whole job is to show the syntax. Reporting those as broken paths is the false
 * positive that gets a check switched off, so an example that points nowhere
 * belongs inside a fence and is exempt by construction rather than by a list.
 */
function stripFences(text) {
  let inFence = false;
  return text
    .split('\n')
    .map((line) => {
      if (/^\s*(```|~~~)/.test(line)) {
        inFence = !inFence;
        return '';
      }
      return inFence ? '' : line;
    })
    .join('\n');
}

// Every path this store cites, minus the trailing punctuation of the sentence it
// sits in. Written once, because the same scan now runs over every root file
// rather than over the catalog alone.
const CITED_PATH_RE =
  /(?:\.claude|\.github|company-wiki|clients|raw|archive|scripts)\/[A-Za-z0-9._/-]+/g;

function citedPaths(text) {
  const out = new Set();
  for (const raw of stripFences(text).match(CITED_PATH_RE) || []) {
    const p = raw.replace(/[.,;:!?)]+$/, '');
    if (p.endsWith('/')) continue;
    out.add(p);
  }
  return out;
}

function rewriteAnchors(text, owned) {
  const changes = [];
  ANCHOR_RE.lastIndex = 0;
  const next = text.replace(ANCHOR_RE, (full, open, key, body, close, offset) => {
    if (key === 'ignore' || !(key in owned)) return full;
    const want = String(owned[key].value);
    if (body !== want) {
      changes.push({ key, from: body.trim() || '(empty)', to: want, line: lineOf(text, offset) });
    }
    return open + want + close;
  });
  return { next, changes };
}

// ---------------------------------------------------------------------------
// Problem classes
// ---------------------------------------------------------------------------

function collectProblems({ owned, items, wikiFolders }, files) {
  const problems = [];
  const add = (kind, where, message, fix) => problems.push({ kind, where, message, fix });

  const citedEverywhere = new Set();

  for (const file of files) {
    const text = fs.readFileSync(abs(file), 'utf8');

    // A misspelled anchor is worse than a missing one: it looks owned in the
    // diff, and no run will ever rewrite it. `count:` singular was in the root
    // template twice, taught as the canonical form, while the script has only
    // ever matched `counts:`.
    const MALFORMED_RE = /<!--\s*\/?count:([a-z0-9][a-z0-9:_-]*)\s*-->/g;
    MALFORMED_RE.lastIndex = 0;
    let bad;
    while ((bad = MALFORMED_RE.exec(text)) !== null) {
      add(
        'MALFORMED ANCHOR',
        `${file}:${lineOf(text, bad.index)}`,
        `${bad[0]} uses count: where this script matches counts: only.`,
        `Write it as <!-- counts:${bad[1]} -->N<!-- /counts:${bad[1]} -->. A number inside a misspelled anchor is never rewritten and never reported, which is the unowned number this tool exists to prevent.`,
      );
    }

    const starts = commentStarts(text);
    for (const a of readAnchors(text)) {
      if (!starts.has(a.at)) {
        add(
          'NESTED ANCHOR',
          `${file}:${a.line}`,
          `counts:${a.key} sits inside another HTML comment.`,
          'HTML comments do not nest, so the enclosing block ends at this anchor and everything after it renders as body text. Move the anchor out of the comment, or move the explanation into visible prose.',
        );
      }
      if (a.key === 'ignore') continue;

      if (!(a.key in owned)) {
        const gone = a.key.startsWith('wiki:') && !wikiFolders.includes(a.key.slice(5));
        add(
          'ORPHAN ANCHOR',
          `${file}:${a.line}`,
          `counts:${a.key} - this script does not know how to fill it.` +
            (gone ? ` company-wiki/${a.key.slice(5)}/ does not exist, so the folder was renamed or removed.` : ''),
          'Add the key to measure() so a script owns it, or delete the anchor. An anchor nobody owns is the exact failure this tool exists to prevent.',
        );
        continue;
      }

      const want = String(owned[a.key].value);
      if (a.body !== want) {
        add(
          'STALE ANCHOR',
          `${file}:${a.line}`,
          `counts:${a.key} expected ${want}, found ${a.body.trim() || '(empty)'}`,
          'Run: node scripts/refresh-counts.mjs --write',
        );
      }
    }

    const masked = maskAnchors(text);
    for (const [re, key] of OWNED_NOUNS) {
      re.lastIndex = 0;
      let m;
      while ((m = re.exec(masked)) !== null) {
        add(
          'UNANCHORED NUMBER',
          `${file}:${lineOf(masked, m.index)}`,
          `"${m[0].trim()}" is a count this script owns, sitting outside an anchor.`,
          `Wrap it: <!-- counts:${key} -->${owned[key].value}<!-- /counts:${key} -->` +
            '\n    Or, if it is genuinely not a count of anything on disk, mark it and say why:' +
            '\n    <!-- counts:ignore -->' + m[0].trim() + '<!-- /counts:ignore -->',
        );
      }
    }

    // Path integrity, over EVERY root file rather than over the catalog alone.
    // Scoping this to INDEX.md is how the root context file came to name five
    // rule files that do not exist, a refresher under the wrong extension in four
    // places, and a scheduled job the repo does not ship, with the check green
    // through all of it. The file the runtime loads first is the one where a
    // broken pointer costs the most.
    for (const p of citedPaths(text)) {
      citedEverywhere.add(p);
      if (ABSENT_BY_DESIGN.includes(p) || fs.existsSync(abs(p))) continue;
      add(
        'DANGLING PATH',
        `${file}`,
        `cites ${p}, which does not exist on disk.`,
        'Restore the file, fix the path, or remove the claim. A context file pointing at something that is not there is read as fact by an agent and gets stopped believing by a human, in that order. An example that points nowhere on purpose belongs inside a fenced code block.',
      );
    }
  }

  // Every rule on disk has to be named in a root file, because the rules layer is
  // discovered by glob at load time and is invisible in the tree otherwise. The
  // reverse direction is covered by DANGLING PATH above.
  for (const r of filesIn('.claude/rules', ['.md'])) {
    if (citedEverywhere.has(r)) continue;
    add(
      'UNCITED RULE',
      r,
      `is on disk and no root file names it.`,
      `Add a row for it to the rule index in CLAUDE.md and a line in ${CATALOG}, with its paths: glob and what it narrows. A rule nobody can find in the index is a rule nobody knows loaded.`,
    );
  }

  // Catalog coverage. Mechanical membership only, never categorisation.
  if (fs.existsSync(abs(CATALOG))) {
    const catalog = fs.readFileSync(abs(CATALOG), 'utf8');
    // Headings are quoted back to the human in the orphan report, so strip the
    // anchor markup out of them first. A fix message that reads like machine
    // output is a fix message people skip.
    const headings = (catalog.match(/^#{2,3}\s+(.+)$/gm) || [])
      .map((h) => h.replace(/^#+\s+/, '').replace(/<!--[\s\S]*?-->/g, '').replace(/\s+/g, ' ').trim())
      .map((h) => h.replace(/\s*\(\s*\d*\s*(pages?|skills?|rules?)?\s*\)\s*$/i, '').trim())
      .filter((h) => h && !/^orphan/i.test(h));

    for (const [group, paths] of Object.entries(items)) {
      for (const p of paths) {
        if (!catalog.includes(p)) {
          add(
            'ORPHAN ITEM',
            p,
            `exists on disk (${group}) and is absent from ${CATALOG}.`,
            `This script does not guess categories. File it under one of: ${headings.join(', ')}. Then re-run.`,
          );
        }
      }
    }

    // Path integrity for the catalog is handled by the DANGLING PATH scan above,
    // which runs over every root file. The catalog is one of them.
  }

  // Two cheap invariants that each catch a whole class of decay.
  for (const f of filesIn('company-wiki', ['.md'])) {
    if (EXEMPT.includes(f)) continue;
    add(
      'INVARIANT',
      f,
      'sits at the root of the company wiki.',
      'Every wiki page belongs in a service-line folder. A file at the wiki root means the taxonomy has a hole, and naming the hole beats leaving the orphan.',
    );
  }
  for (const c of subdirs('clients')) {
    if (!fs.existsSync(abs(`clients/${c}/${c}.md`))) {
      add(
        'INVARIANT',
        `clients/${c}/`,
        `has no clients/${c}/${c}.md.`,
        'Every account folder carries its same-named one-pager. A single missing file is then a signal rather than noise.',
      );
    }
  }

  return problems;
}

function report(problems) {
  const width = Math.max(...problems.map((p) => p.kind.length));
  const gutter = ' '.repeat(width);
  for (const p of problems) {
    console.log(`${p.kind.padEnd(width)}  ${p.where}`);
    console.log(`${gutter}  ${p.message}`);
    const fix = p.fix.split('\n');
    console.log(`${gutter}  -> ${fix[0]}`);
    for (const line of fix.slice(1)) console.log(`${gutter}     ${line.trim()}`);
    console.log('');
  }
}

const plural = (n, one, many) => `${n} ${n === 1 ? one : many}`;

const summary = (owned) =>
  [
    plural(owned.skills.value, 'skill', 'skills'),
    plural(owned.rules.value, 'rule', 'rules'),
    plural(owned.hooks.value, 'hook', 'hooks'),
    plural(owned.commands.value, 'command', 'commands'),
    plural(owned.agents.value, 'agent', 'agents'),
    plural(owned.roots.value, 'content root', 'content roots'),
    plural(owned.wiki.value, 'wiki page', 'wiki pages'),
    plural(owned.clients.value, 'client folder', 'client folders'),
  ].join(', ');

// ---------------------------------------------------------------------------
// Modes
// ---------------------------------------------------------------------------

function manifest(state, files) {
  const { owned } = state;
  console.log('counts refresher for this Company OS');
  console.log(`repo root: ${ROOT}`);
  console.log('');
  console.log('OWNED - measured from disk, rewritten in place inside a named anchor');
  const keys = Object.keys(owned);
  const pad = Math.max(...keys.map((k) => k.length)) + 8;
  for (const k of keys) {
    console.log(
      `  ${`counts:${k}`.padEnd(pad)} ${String(owned[k].value).padStart(4)}   ${owned[k].source}`,
    );
  }
  console.log('');
  console.log(`  written into: ${files.join(', ')}`);
  console.log('  (every .md file at the repo root, discovered at runtime)');
  console.log('');
  console.log('NOT OWNED - this script will never write these, and never guesses at them');
  console.log('  - which category a file belongs under, in INDEX.md or anywhere else');
  console.log('  - the one-line description and routing phrases on a catalog entry');
  console.log('  - section headings, ordering, and every word outside an anchor');
  console.log('  - dates. There is no last-updated column anywhere in this kit, on purpose:');
  console.log('    a hand-typed date is the drift generator this tool exists to remove.');
  console.log('  - account folders and raw input, which churn weekly. Forcing a catalog edit');
  console.log('    per account is how a catalog stops being maintained at all.');
  console.log('  - anything outside .claude/, company-wiki/, clients/, raw/, .github/workflows/');
  console.log('');
  console.log('ALSO CHECKED, NEVER FIXED - reported and failed, because each one is a judgment call');
  console.log('  - ORPHAN ANCHOR      an anchor this script cannot fill');
  console.log('  - NESTED ANCHOR      an anchor inside another HTML comment, which breaks the page');
  console.log('  - MALFORMED ANCHOR   count: where the only form it matches is counts:');
  console.log('  - UNANCHORED NUMBER  a count it owns, written outside an anchor');
  console.log('  - ORPHAN ITEM        a file on disk that INDEX.md does not mention');
  console.log('  - DANGLING PATH      any root file citing a path that is not on disk');
  console.log('  - UNCITED RULE       a rule on disk that no root file names');
  console.log('  - INVARIANT          a page at the wiki root, or an account folder with no one-pager');
  console.log('');
  console.log('  node scripts/refresh-counts.mjs --write    rewrite the anchors');
  console.log('  node scripts/refresh-counts.mjs --check    read only, exits non-zero on any problem');
}

function main() {
  const args = process.argv.slice(2);
  const unknown = args.filter((a) => !['--write', '--check', '--help', '-h'].includes(a));
  if (unknown.length) {
    console.error(`refresh-counts: unknown argument ${unknown.join(' ')}`);
    console.error('Valid: --write, --check, or no arguments for the ownership manifest.');
    process.exit(2);
  }

  if (!fs.existsSync(abs('README.md')) || !isDir('.claude')) {
    console.error(`refresh-counts: ${ROOT} does not look like a Company OS repo.`);
    console.error('Expected a README.md and a .claude/ directory beside scripts/.');
    process.exit(2);
  }

  const state = measure();
  const files = targetFiles();

  if (args.includes('--help') || args.includes('-h') || args.length === 0) {
    manifest(state, files);
    return;
  }

  const check = args.includes('--check');

  if (!check) {
    let rewritten = 0;
    for (const file of files) {
      const text = fs.readFileSync(abs(file), 'utf8');
      const { next, changes } = rewriteAnchors(text, state.owned);
      if (next !== text) fs.writeFileSync(abs(file), next);
      for (const c of changes) {
        console.log(`${file}:${c.line}  counts:${c.key}  ${c.from} -> ${c.to}`);
        rewritten++;
      }
    }
    console.log(rewritten === 0 ? 'anchors already current, nothing rewritten.' : `${rewritten} anchor(s) rewritten.`);
    console.log('');
  }

  // Re-measured against what is on disk now, so --write reports the state it left
  // behind rather than the state it found.
  const remaining = collectProblems(state, files);

  if (remaining.length === 0) {
    console.log(`counts are current (${summary(state.owned)})`);
    console.log(`every number in ${files.join(', ')} sits inside an anchor this script owns.`);
    return;
  }

  report(remaining);
  const noun = remaining.length === 1 ? 'problem' : 'problems';
  console.error(`FAIL: ${remaining.length} ${noun}. Counts are mechanical and get fixed by --write. Everything above is a judgment call and needs a human.`);
  process.exit(1);
}

main();
