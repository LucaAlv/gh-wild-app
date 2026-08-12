type SearchableGuide = {
  id: string;
  title: { de: string; en: string };
  answer: { de: string; en: string };
  keywords: string[];
};

export function normalizeSearch(value: string): string {
  return value
    .toLocaleLowerCase('de-DE')
    .replace(/ß/g, 'ss')
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^\p{L}\p{N}]+/gu, ' ')
    .trim()
    .replace(/\s+/g, ' ');
}

export function guideResults<T extends SearchableGuide>(query: string, entries: T[]): T[] {
  const normalizedQuery = normalizeSearch(query);
  const alphabetical = (left: T, right: T) => {
    const comparison = normalizeSearch(left.title.de).localeCompare(normalizeSearch(right.title.de), 'de');
    return comparison || left.id.localeCompare(right.id);
  };
  if (!normalizedQuery) return [...entries].sort(alphabetical);

  const tokens = normalizedQuery.split(' ');
  return entries
    .map((entry) => {
      const titles = [normalizeSearch(entry.title.de), normalizeSearch(entry.title.en)];
      const answers = [normalizeSearch(entry.answer.de), normalizeSearch(entry.answer.en)];
      const keywords = entry.keywords.map(normalizeSearch);
      const searchable = [...titles, ...keywords, ...answers];
      if (!tokens.every((token) => searchable.some((value) => value.includes(token)))) return null;
      const rank = titles.includes(normalizedQuery) ? 0
        : titles.some((value) => value.startsWith(normalizedQuery)) ? 1
          : titles.some((value) => value.includes(normalizedQuery)) ? 2
            : keywords.some((value) => value.includes(normalizedQuery)) ? 3 : 4;
      return { entry, rank };
    })
    .filter((value): value is { entry: T; rank: number } => value !== null)
    .sort((left, right) => left.rank - right.rank || alphabetical(left.entry, right.entry))
    .map(({ entry }) => entry);
}
