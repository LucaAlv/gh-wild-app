import { describe, expect, it } from 'vitest';
import { guideResults, normalizeSearch } from './guideSearch';

const entries = [
  { id: 'answer', title: { de: 'Internet', en: 'Internet' }, answer: { de: 'WLAN verfügbar', en: 'Wi-Fi available' }, keywords: [] },
  { id: 'title', title: { de: 'WLAN', en: 'Wi-Fi' }, answer: { de: 'Sofort verbinden', en: 'Connect instantly' }, keywords: ['network'] },
];

describe('guide search', () => {
  it('normalizes case, diacritics, punctuation and sharp S', () => {
    expect(normalizeSearch('  CAFÉ—Straße! ')).toBe('cafe strasse');
  });

  it('ranks a title before an answer', () => {
    expect(guideResults('WLAN', entries).map(({ id }) => id)).toEqual(['title', 'answer']);
  });

  it('matches bilingual keywords', () => {
    expect(guideResults('network', entries).map(({ id }) => id)).toEqual(['title']);
  });
});
