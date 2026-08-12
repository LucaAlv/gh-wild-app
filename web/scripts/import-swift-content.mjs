import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const here = path.dirname(fileURLToPath(import.meta.url));
const repo = path.resolve(here, '../..');
const contentRoot = path.resolve(here, '../src/content');

function source(file) {
  return fs.readFileSync(path.join(repo, 'GaestehausWild/Content', file), 'utf8');
}

function scanBalanced(value, start, open, close) {
  let depth = 0;
  let string = false;
  let triple = false;
  for (let index = start; index < value.length; index += 1) {
    if (!string && value.startsWith('"""', index)) {
      string = true;
      triple = true;
      index += 2;
      continue;
    }
    if (string && triple && value.startsWith('"""', index)) {
      string = false;
      triple = false;
      index += 2;
      continue;
    }
    if (!triple && value[index] === '"' && value[index - 1] !== '\\') {
      string = !string;
      continue;
    }
    if (string) continue;
    if (value[index] === open) depth += 1;
    if (value[index] === close) {
      depth -= 1;
      if (depth === 0) return index;
    }
  }
  throw new Error(`Unbalanced ${open}${close}`);
}

function splitTopLevel(value, separator = ',') {
  const parts = [];
  let start = 0;
  let parens = 0;
  let brackets = 0;
  let string = false;
  let triple = false;
  for (let index = 0; index < value.length; index += 1) {
    if (!string && value.startsWith('"""', index)) {
      string = true;
      triple = true;
      index += 2;
      continue;
    }
    if (string && triple && value.startsWith('"""', index)) {
      string = false;
      triple = false;
      index += 2;
      continue;
    }
    if (!triple && value[index] === '"' && value[index - 1] !== '\\') {
      string = !string;
      continue;
    }
    if (string) continue;
    if (value[index] === '(') parens += 1;
    if (value[index] === ')') parens -= 1;
    if (value[index] === '[') brackets += 1;
    if (value[index] === ']') brackets -= 1;
    if (value[index] === separator && parens === 0 && brackets === 0) {
      parts.push(value.slice(start, index).trim());
      start = index + 1;
    }
  }
  const tail = value.slice(start).trim();
  if (tail) parts.push(tail);
  return parts;
}

function unquote(value) {
  const trimmed = value.trim();
  if (trimmed.startsWith('"""')) {
    return trimmed.slice(3, -3).replace(/^\s*\n/, '').replace(/\n\s*$/, '');
  }
  return JSON.parse(trimmed);
}

function argumentsOf(call) {
  const start = call.indexOf('(');
  const inner = call.slice(start + 1, scanBalanced(call, start, '(', ')'));
  const positional = [];
  const named = {};
  for (const part of splitTopLevel(inner)) {
    let colon = -1;
    let parens = 0;
    let brackets = 0;
    let string = false;
    let triple = false;
    for (let index = 0; index < part.length; index += 1) {
      if (!string && part.startsWith('"""', index)) {
        string = true;
        triple = true;
        index += 2;
        continue;
      }
      if (string && triple && part.startsWith('"""', index)) {
        string = false;
        triple = false;
        index += 2;
        continue;
      }
      if (!triple && part[index] === '"' && part[index - 1] !== '\\') string = !string;
      if (string) continue;
      if (part[index] === '(') parens += 1;
      if (part[index] === ')') parens -= 1;
      if (part[index] === '[') brackets += 1;
      if (part[index] === ']') brackets -= 1;
      if (part[index] === ':' && parens === 0 && brackets === 0) {
        colon = index;
        break;
      }
    }
    if (colon === -1) positional.push(part);
    else named[part.slice(0, colon).trim()] = part.slice(colon + 1).trim();
  }
  return { positional, named };
}

function arrayBody(swift, marker) {
  const markerIndex = swift.indexOf(marker);
  if (markerIndex === -1) throw new Error(`Missing marker ${marker}`);
  const assignment = swift.indexOf('=', markerIndex);
  const start = swift.indexOf('[', assignment);
  const end = scanBalanced(swift, start, '[', ']');
  return swift.slice(start + 1, end);
}

function initCalls(body) {
  const calls = [];
  let cursor = 0;
  while (cursor < body.length) {
    const start = body.indexOf('.init(', cursor);
    if (start === -1) break;
    const paren = body.indexOf('(', start);
    const end = scanBalanced(body, paren, '(', ')');
    calls.push(body.slice(start, end + 1));
    cursor = end + 1;
  }
  return calls;
}

function localized(value) {
  const constants = {
    'Content.StayCopy.parking': {
      de: 'Kostenfreie Parkplätze finden Sie direkt vor dem Haus.',
      en: 'Free parking is available directly outside the guesthouse.',
    },
    'Content.StayCopy.keyHandover': {
      de: 'Ihre Schlüsselübergabe stimmen wir persönlich mit Ihnen ab.',
      en: 'We arrange your key handover with you personally.',
    },
    'Content.StayCopy.lateArrival': {
      de: 'Sie kommen später? Rufen Sie uns kurz an – wir vereinbaren eine flexible Schlüsselübergabe.',
      en: 'Arriving later? Give us a quick call and we will arrange a flexible key handover.',
    },
  };
  if (constants[value.trim()]) return constants[value.trim()];
  const { named } = argumentsOf(value);
  return { de: unquote(named.de), en: unquote(named.en) };
}

function stringArray(value) {
  const body = value.trim().slice(1, -1);
  return splitTopLevel(body).map(unquote);
}

function localizedArray(value) {
  return initCalls(value).map(localized);
}

function enumArray(value) {
  return splitTopLevel(value.trim().slice(1, -1)).map((item) => item.trim().replace(/^\./, ''));
}

function optionalLocalized(value) {
  return value ? localized(value) : undefined;
}

function optionalString(value) {
  return value ? unquote(value) : undefined;
}

function resolvedString(value) {
  const constants = {
    'Content.phoneURL': 'tel:+49911996910',
    'Content.email': 'info@gaestehaus-wild.com',
  };
  return constants[value.trim()] ?? unquote(value);
}

function write(collection, id, data) {
  const directory = path.join(contentRoot, collection);
  fs.mkdirSync(directory, { recursive: true });
  fs.writeFileSync(path.join(directory, `${id}.yaml`), `${JSON.stringify(data, null, 2)}\n`);
}

function parseRooms() {
  const swift = source('Content.swift');
  const rooms = initCalls(arrayBody(swift, 'static let rooms'));
  for (const call of rooms) {
    const { named } = argumentsOf(call);
    const id = unquote(named.id);
    const room = {
      name: localized(named.name),
      price: Number(named.price),
      occupancy: id === 'family2' ? {
        de: '3 Erwachsene & 1 Kind bis 6 Jahre oder 2 Erwachsene, 1 Kind ab 7 & 1 Kind bis 6 Jahre',
        en: '3 adults & 1 child up to age 6, or 2 adults, 1 child aged 7+ & 1 child up to age 6',
      } : localized(named.occupancy),
      description: localized(named.description),
      images: stringArray(named.images),
    };
    write('rooms', id, room);
  }
}

function parseGuide() {
  const swift = source('Content+Guide.swift');
  const entries = initCalls(arrayBody(swift, 'static let guide'));
  for (const call of entries) {
    const { named } = argumentsOf(call);
    const actions = named.actions ? splitTopLevel(named.actions.slice(1, -1)).map((action) => {
      if (action.startsWith('.call(')) return { type: 'call', target: resolvedString(argumentsOf(action).positional[0]) };
      if (action.startsWith('.map(')) return { type: 'map', target: unquote(argumentsOf(action).named.query) };
      if (action.startsWith('.link(')) return { type: 'link', target: unquote(argumentsOf(action).positional[0]) };
      if (action.startsWith('.page(')) return { type: 'page', target: argumentsOf(action).positional[0].replace(/^\./, '') };
      throw new Error(`Unknown guide action: ${action}`);
    }) : [];
    const id = unquote(named.id);
    const answer = localized(named.answer);
    const placeholder = /BITTE VON DER FAMILIE BESTÄTIGEN|PLEASE CONFIRM WITH THE FAMILY/i;
    for (const locale of ['de', 'en']) {
      if (placeholder.test(answer[locale])) {
        answer[locale] = locale === 'de'
          ? 'Bitte fragen Sie uns direkt – wir helfen Ihnen gerne persönlich weiter.'
          : 'Please ask us directly—we will be happy to help in person.';
      }
    }
    write('guide', id, {
      symbol: unquote(named.symbol),
      title: localized(named.title),
      answer,
      keywords: named.keywords ? stringArray(named.keywords) : [],
      category: named.category.replace(/^\./, ''),
      actions,
      needsOwnerReview: placeholder.test(named.answer),
    });
  }
}

function parseTravel(value) {
  return initCalls(value).map((call) => {
    const { named } = argumentsOf(call);
    return {
      minutes: Number(named.minutes),
      mode: named.mode.replace(/^\./, ''),
      ...(named.note ? { note: localized(named.note) } : {}),
    };
  });
}

function parseNearby() {
  const swift = source('Content+Nearby.swift');
  const entries = initCalls(arrayBody(swift, 'static let nearbyPlaces'));
  for (const call of entries) {
    const { named } = argumentsOf(call);
    const id = unquote(named.id);
    write('nearby', id, {
      name: localized(named.name),
      subtitle: localized(named.subtitle),
      description: localized(named.description),
      latitude: Number(named.latitude),
      longitude: Number(named.longitude),
      categories: enumArray(named.categories),
      ...(named.image ? { image: unquote(named.image) } : {}),
      travel: parseTravel(named.travel),
      ...(named.openingHours ? { openingHours: optionalLocalized(named.openingHours) } : {}),
      ...(named.priceHint ? { priceHint: optionalLocalized(named.priceHint) } : {}),
      ...(named.familyNote ? { familyNote: optionalLocalized(named.familyNote) } : {}),
      ...(named.website ? { website: optionalString(named.website) } : {}),
      ...(named.phone ? { phone: optionalString(named.phone) } : {}),
    });
  }
}

function parseArrival() {
  const swift = source('Content+Arrival.swift');
  const entries = initCalls(arrayBody(swift, 'static let routes'));
  for (const call of entries) {
    const { named } = argumentsOf(call);
    const id = unquote(named.id);
    write('arrival', id, {
      destination: localized(named.destination),
      symbol: unquote(named.symbol),
      durationSummary: localized(named.durationSummary),
      steps: localizedArray(named.steps),
      ...(named.tip ? { tip: localized(named.tip) } : {}),
    });
  }
}

for (const collection of ['rooms', 'guide', 'nearby', 'arrival']) {
  fs.rmSync(path.join(contentRoot, collection), { recursive: true, force: true });
}
parseRooms();
parseGuide();
parseNearby();
parseArrival();

console.log('Imported Swift content into Astro collections.');
