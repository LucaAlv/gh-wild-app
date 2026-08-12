import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const contentRoot = path.join(root, 'src/content');

function entries(collection) {
  const directory = path.join(contentRoot, collection);
  return fs.readdirSync(directory)
    .filter((file) => file.endsWith('.yaml'))
    .map((file) => ({ id: file.replace(/\.yaml$/, ''), data: JSON.parse(fs.readFileSync(path.join(directory, file), 'utf8')) }));
}

function assert(condition, message) {
  if (!condition) throw new Error(message);
}

function walk(value, visitor, location = 'content') {
  if (typeof value === 'string') visitor(value, location);
  else if (Array.isArray(value)) value.forEach((child, index) => walk(child, visitor, `${location}[${index}]`));
  else if (value && typeof value === 'object') Object.entries(value).forEach(([key, child]) => walk(child, visitor, `${location}.${key}`));
}

const expected = { rooms: 7, guide: 33, nearby: 21, arrival: 3 };
for (const [collection, count] of Object.entries(expected)) {
  assert(entries(collection).length === count, `${collection} must contain exactly ${count} entries`);
}

for (const collection of ['rooms', 'guide', 'nearby', 'arrival', 'pages', 'legal', 'settings']) {
  for (const entry of entries(collection)) {
    walk(entry.data, (value, location) => {
      assert(!/BITTE.*BESTÄTIGEN|BITTE-GAST-WLAN|PLEASE CONFIRM WITH THE FAMILY/i.test(value), `${collection}/${entry.id}: placeholder at ${location}`);
      if (location.endsWith('.de') || location.endsWith('.en')) {
        assert(value.trim().length > 0, `${collection}/${entry.id}: empty localized value at ${location}`);
      }
    });
  }
}

const guide = entries('guide');
assert(guide.some(({ id, data }) => id === 'emergency-112' && JSON.stringify(data).includes('112')), 'Emergency entry 112 is required');
assert(guide.some(({ id, data }) => id === 'emergency-110' && JSON.stringify(data).includes('110')), 'Emergency entry 110 is required');

const internalPages = new Set(['guestNow', 'breakfast']);
for (const { id, data } of guide) {
  for (const action of data.actions) {
    if (action.type === 'call') assert(/^tel:\+?\d+$/.test(action.target), `${id}: invalid telephone action`);
    if (action.type === 'link') assert(/^https:\/\//.test(action.target), `${id}: external links must use HTTPS`);
    if (action.type === 'page') assert(internalPages.has(action.target), `${id}: unknown page action ${action.target}`);
    if (action.type === 'map') assert(action.target.trim().length > 0, `${id}: empty map target`);
  }
}

const gallery = entries('settings').find(({ id }) => id === 'gallery')?.data.images;
assert(Array.isArray(gallery) && gallery.length === 25, 'Gallery must contain exactly 25 images');
for (const image of gallery) {
  assert(fs.existsSync(path.join(root, 'src/assets/images', `${image}.jpg`)), `Missing gallery asset ${image}`);
}

console.log('Content validation passed: 7 rooms, 33 guide entries, 21 nearby places, 3 routes and 25 gallery images.');
