import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const dist = path.join(root, 'dist');
const criticalFiles = [
  'index.html', 'gast/index.html', 'gaestemappe/index.html', 'anreise/index.html',
  'mein-aufenthalt/index.html', 'kontakt/index.html', 'en/index.html', 'en/guest/index.html',
  'en/house-guide/index.html', 'en/getting-here/index.html', 'en/my-stay/index.html', 'en/contact/index.html',
];
const assets = new Set();

for (const file of criticalFiles) {
  const html = fs.readFileSync(path.join(dist, file), 'utf8');
  for (const match of html.matchAll(/"(\/_astro\/[^"?#]+)"/g)) assets.add(match[1]);
}

for (const asset of [...assets]) {
  if (!asset.endsWith('.css')) continue;
  const css = fs.readFileSync(path.join(dist, asset), 'utf8');
  for (const match of css.matchAll(/url\(["']?(\/_astro\/[^)"']+)/g)) assets.add(match[1]);
}

const serviceWorkerPath = path.join(dist, 'sw.js');
const serviceWorker = fs.readFileSync(serviceWorkerPath, 'utf8');
const injected = serviceWorker.replace('[/* INJECT_ASSETS */]', JSON.stringify([...assets].sort()));
if (injected === serviceWorker) throw new Error('Service-worker asset placeholder was not found');
fs.writeFileSync(serviceWorkerPath, injected);
console.log(`Service worker precaches ${assets.size} hashed application assets.`);
