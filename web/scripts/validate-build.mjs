import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const dist = path.join(root, 'dist');

function files(directory) {
  return fs.readdirSync(directory, { withFileTypes: true }).flatMap((entry) => {
    const target = path.join(directory, entry.name);
    return entry.isDirectory() ? files(target) : [target];
  });
}

function assert(condition, message) {
  if (!condition) throw new Error(message);
}

const htmlFiles = files(dist).filter((file) => file.endsWith('.html'));
const broken = [];
for (const file of htmlFiles) {
  const html = fs.readFileSync(file, 'utf8');
  assert(!/BITTE.*BESTÄTIGEN|BITTE-GAST-WLAN|PLEASE CONFIRM WITH THE FAMILY/i.test(html), `${file}: unresolved placeholder`);
  if (!file.includes(`${path.sep}admin${path.sep}`)) {
    assert((html.match(/<link rel="alternate" hreflang=/g) ?? []).length === 3, `${file}: missing language alternates`);
    if (process.env.PUBLIC_SITE_LIVE !== 'true') assert(html.includes('noindex, nofollow'), `${file}: preview page is indexable`);
  }

  for (const match of html.matchAll(/(?:href|src|component-url|renderer-url)="([^"]+)"/g)) {
    const reference = match[1];
    if (!reference.startsWith('/') || reference.startsWith('//') || reference.startsWith('/api/')) continue;
    const pathname = decodeURIComponent(reference.split(/[?#]/)[0]);
    const relative = pathname.replace(/^\//, '');
    const candidates = pathname === '/'
      ? [path.join(dist, 'index.html')]
      : [path.join(dist, relative), path.join(dist, relative, 'index.html')];
    if (!candidates.some(fs.existsSync)) broken.push(`${path.relative(dist, file)} → ${reference}`);
  }
}

assert(broken.length === 0, `Broken internal references:\n${broken.join('\n')}`);
const robots = fs.readFileSync(path.join(dist, 'robots.txt'), 'utf8');
assert(process.env.PUBLIC_SITE_LIVE === 'true' ? robots.includes('Allow: /') : robots.includes('Disallow: /'), 'robots.txt does not match build mode');
const worker = fs.readFileSync(path.join(dist, 'sw.js'), 'utf8');
for (const island of ['GuideSearch', 'StayPlanner', 'WifiCard']) assert(worker.includes(island), `Offline cache misses ${island}`);

console.log(`Build validation passed: ${htmlFiles.length} HTML documents and all internal references are valid.`);
