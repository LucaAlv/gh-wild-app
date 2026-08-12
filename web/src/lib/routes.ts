import type { Locale, RouteDefinition } from './types';

export const routes: RouteDefinition[] = [
  { key: 'home', kind: 'home', de: '', en: '', contentId: 'home' },
  { key: 'rooms', kind: 'rooms', de: 'zimmer', en: 'rooms' },
  { key: 'single', kind: 'room', de: 'einzelzimmer', en: 'rooms/single-room', roomId: 'single' },
  { key: 'double', kind: 'room', de: 'doppelzimmer', en: 'rooms/double-room', roomId: 'double' },
  { key: 'triple', kind: 'room', de: 'dreibettzimmer', en: 'rooms/triple-room', roomId: 'triple' },
  { key: 'family', kind: 'room', de: 'familienzimmer', en: 'rooms/family-room', roomId: 'family' },
  { key: 'family2', kind: 'room', de: 'familienzimmer-2', en: 'rooms/large-family-room', roomId: 'family2' },
  { key: 'quad', kind: 'room', de: 'vierbettzimmer', en: 'rooms/quadruple-room', roomId: 'quad' },
  { key: 'basement', kind: 'room', de: 'souterrainzimmer', en: 'rooms/lower-ground-floor-room', roomId: 'basement' },
  { key: 'breakfast', kind: 'breakfast', de: 'frühstück', en: 'breakfast', contentId: 'breakfast' },
  { key: 'garden', kind: 'garden', de: 'garten', en: 'garden', contentId: 'garden' },
  { key: 'about', kind: 'about', de: 'über-uns', en: 'about', contentId: 'about' },
  { key: 'gallery', kind: 'gallery', de: 'galerie', en: 'gallery' },
  { key: 'contact', kind: 'contact', de: 'kontakt', en: 'contact' },
  { key: 'nearby', kind: 'nearby', de: 'in-der-nähe', en: 'nearby' },
  { key: 'services', kind: 'services', de: 'sonstige-leistungen', en: 'other-services', contentId: 'services' },
  { key: 'vouchers', kind: 'vouchers', de: 'gutscheine', en: 'gift-vouchers', contentId: 'vouchers' },
  { key: 'goodToKnow', kind: 'goodToKnow', de: 'wissenswertes', en: 'good-to-know', contentId: 'good-to-know' },
  { key: 'inquiry', kind: 'inquiry', de: 'anfrage', en: 'inquiry' },
  { key: 'thanks', kind: 'thanks', de: 'vielen-dank', en: 'thank-you', noindex: true },
  { key: 'guest', kind: 'guest', de: 'gast', en: 'guest', noindex: true },
  { key: 'stay', kind: 'stay', de: 'mein-aufenthalt', en: 'my-stay' },
  { key: 'guide', kind: 'guide', de: 'gaestemappe', en: 'house-guide' },
  { key: 'arrival', kind: 'arrival', de: 'anreise', en: 'getting-here' },
  { key: 'impressum', kind: 'legal', de: 'impressum', en: 'legal-notice', contentId: 'impressum' },
  { key: 'datenschutz', kind: 'legal', de: 'datenschutz', en: 'privacy', contentId: 'datenschutz' },
  { key: 'agb', kind: 'legal', de: 'agb', en: 'terms', contentId: 'agb' },
];

export function hrefFor(key: string, locale: Locale): string {
  const route = routes.find((candidate) => candidate.key === key);
  if (!route) throw new Error(`Unknown route: ${key}`);
  const slug = route[locale];
  return locale === 'en' ? `/en${slug ? `/${slug}` : ''}` : `/${slug}`;
}

export function routeForSlug(slug: string, locale: Locale): RouteDefinition | undefined {
  return routes.find((route) => route[locale] === slug);
}

export const navKeys = ['rooms', 'breakfast', 'gallery', 'nearby', 'goodToKnow', 'contact'];

export const labels = {
  de: {
    rooms: 'Zimmer', breakfast: 'Frühstück', gallery: 'Galerie', nearby: 'In der Nähe',
    goodToKnow: 'Wissenswertes', contact: 'Kontakt', inquiry: 'Anfragen', guest: 'Ich bin zu Gast',
  },
  en: {
    rooms: 'Rooms', breakfast: 'Breakfast', gallery: 'Gallery', nearby: 'Nearby',
    goodToKnow: 'Good to know', contact: 'Contact', inquiry: 'Enquire', guest: "I'm staying here",
  },
} as const;
