export type Locale = 'de' | 'en';
export type Localized = { de: string; en: string };
export type PageKind =
  | 'home' | 'rooms' | 'room' | 'gallery' | 'contact' | 'breakfast' | 'garden'
  | 'about' | 'services' | 'vouchers' | 'nearby' | 'arrival' | 'guide'
  | 'guest' | 'stay' | 'inquiry' | 'thanks' | 'legal' | 'goodToKnow';

export type RouteDefinition = {
  key: string;
  kind: PageKind;
  de: string;
  en: string;
  roomId?: string;
  contentId?: string;
  noindex?: boolean;
};

export const localize = <T extends Localized>(value: T, locale: Locale) => value[locale];
