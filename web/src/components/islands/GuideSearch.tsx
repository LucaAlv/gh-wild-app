import { useMemo, useState } from 'react';
import { guideResults } from '../../lib/guideSearch';

type Entry = {
  id: string;
  symbol: string;
  title: { de: string; en: string };
  answer: { de: string; en: string };
  keywords: string[];
  category: string;
  actions: { type: 'call' | 'map' | 'link' | 'page'; target: string }[];
};

const categories = {
  de: { all: 'Alle', emergency: 'Notfall', room: 'Im Zimmer', house: 'Im Haus', food: 'Essen & Trinken', practical: 'Praktisches', departure: 'An- & Abreise' },
  en: { all: 'All', emergency: 'Emergency', room: 'In your room', house: 'Around the house', food: 'Food & drink', practical: 'Practical', departure: 'Arrival & departure' },
};

function actionHref(action: Entry['actions'][number], locale: 'de' | 'en') {
  if (action.type === 'map') return `https://maps.apple.com/?q=${encodeURIComponent(action.target)}`;
  if (action.type === 'page') {
    if (action.target === 'guestNow') return locale === 'de' ? '/gast' : '/en/guest';
    if (action.target === 'breakfast') return locale === 'de' ? '/frühstück' : '/en/breakfast';
  }
  return action.target;
}

export default function GuideSearch({ entries, locale }: { entries: Entry[]; locale: 'de' | 'en' }) {
  const [query, setQuery] = useState('');
  const [category, setCategory] = useState('all');
  const copy = categories[locale];
  const results = useMemo(
    () => guideResults(query, entries).filter((entry) => category === 'all' || entry.category === category),
    [query, category, entries],
  );

  return <>
    <div className="search-field">
      <label className="sr-only" htmlFor="guide-search">{locale === 'de' ? 'Gästemappe durchsuchen' : 'Search the house guide'}</label>
      <input
        id="guide-search"
        type="search"
        value={query}
        onChange={(event) => setQuery(event.target.value)}
        placeholder={locale === 'de' ? 'Wonach suchen Sie? WLAN, Handtücher …' : 'What do you need? Wi-Fi, towels …'}
      />
      <span aria-hidden="true">⌕</span>
    </div>
    <div className="filter-row" aria-label={locale === 'de' ? 'Kategorien' : 'Categories'}>
      {Object.entries(copy).map(([key, label]) => (
        <button className="chip" type="button" aria-pressed={category === key} onClick={() => setCategory(key)} key={key}>{label}</button>
      ))}
    </div>
    <p className="muted" aria-live="polite">{locale === 'de' ? `${results.length} Einträge` : `${results.length} entries`}</p>
    <div className="guide-list">
      {results.map((entry) => (
        <details className="guide-card" key={entry.id} id={entry.id}>
          <summary>{entry.title[locale]}</summary>
          <div className="guide-answer">
            <p>{entry.answer[locale]}</p>
            {entry.actions.length > 0 && <div className="guide-actions">
              {entry.actions.map((action, index) => (
                <a className="button secondary compact" href={actionHref(action, locale)} key={`${action.type}-${index}`}>
                  {action.type === 'call' ? (locale === 'de' ? 'Anrufen' : 'Call')
                    : action.type === 'map' ? (locale === 'de' ? 'Karte öffnen' : 'Open map')
                      : action.type === 'page' ? (locale === 'de' ? 'Seite öffnen' : 'Open page')
                        : (locale === 'de' ? 'Website öffnen' : 'Open website')}
                </a>
              ))}
            </div>}
          </div>
        </details>
      ))}
      {results.length === 0 && <div className="empty-state">{locale === 'de' ? 'Dazu haben wir keinen Eintrag gefunden. Fragen Sie uns gerne direkt.' : 'We could not find an entry for that. Please ask us directly.'}</div>}
    </div>
  </>;
}
