import { useMemo, useState } from 'react';
import { distanceInKilometres, formattedDistance } from '../../lib/geo';

type Place = {
  id: string;
  name: { de: string; en: string };
  subtitle: { de: string; en: string };
  description: { de: string; en: string };
  categories: string[];
  latitude: number;
  longitude: number;
  imageUrl?: string;
  travel: { minutes: number; mode: string; note?: { de: string; en: string } }[];
  openingHours?: { de: string; en: string };
  priceHint?: { de: string; en: string };
  familyNote?: { de: string; en: string };
  website?: string;
};

const categoryCopy = {
  de: { all: 'Alle', food: 'Essen & Trinken', withKids: 'Mit Kindern', fair: 'Messe & Anreise', rainyDay: 'Bei Regen', shopping: 'Einkaufen', nature: 'Natur & Bewegung' },
  en: { all: 'All', food: 'Food & drink', withKids: 'With children', fair: 'Fair & transport', rainyDay: 'Rainy days', shopping: 'Shopping', nature: 'Nature & outdoors' },
};
const modeIcon: Record<string, string> = { walk: '🚶', bike: '🚲', car: '🚗', transit: '🚆' };
const categoryIcon: Record<string, string> = { food: '🍽', withKids: '◉', fair: '▦', rainyDay: '☂', shopping: '◇', nature: '❦' };

export default function NearbyExplorer({ places, locale }: { places: Place[]; locale: 'de' | 'en' }) {
  const [category, setCategory] = useState('all');
  const results = useMemo(() => places
    .filter((place) => category === 'all' || place.categories.includes(category))
    .sort((left, right) => distanceInKilometres(left.latitude, left.longitude) - distanceInKilometres(right.latitude, right.longitude)), [places, category]);
  const copy = categoryCopy[locale];

  return <>
    <div className="filter-row" aria-label={locale === 'de' ? 'Kategorien' : 'Categories'}>
      {Object.entries(copy).map(([key, label]) => (
        <button className="chip" type="button" aria-pressed={category === key} onClick={() => setCategory(key)} key={key}>{label}</button>
      ))}
    </div>
    <div className="place-grid">
      {results.map((place) => <article className="place-card" key={place.id}>
        {place.imageUrl ? <img src={place.imageUrl} alt="" loading="lazy" /> : <div className="place-icon" aria-hidden="true">{categoryIcon[place.categories[0]] ?? '•'}</div>}
        <div className="card-body">
          <p className="eyebrow">{formattedDistance(place.latitude, place.longitude, locale)}</p>
          <h3>{place.name[locale]}</h3>
          <p className="muted">{place.subtitle[locale]}</p>
          <div className="place-details">
            {place.travel.map((travel, index) => <span className="tag" key={index}>{modeIcon[travel.mode]} {travel.minutes} min</span>)}
          </div>
          <details>
            <summary className="text-link">{locale === 'de' ? 'Mehr erfahren' : 'Learn more'}</summary>
            <p>{place.description[locale]}</p>
            {place.openingHours && <p><strong>{locale === 'de' ? 'Öffnung:' : 'Hours:'}</strong> {place.openingHours[locale]}</p>}
            {place.priceHint && <p><strong>{locale === 'de' ? 'Preis:' : 'Price:'}</strong> {place.priceHint[locale]}</p>}
            {place.familyNote && <p><strong>{locale === 'de' ? 'Unser Tipp:' : 'Our tip:'}</strong> {place.familyNote[locale]}</p>}
            <div className="guide-actions">
              <a className="button secondary compact" href={`https://maps.apple.com/?daddr=${place.latitude},${place.longitude}`}>{locale === 'de' ? 'Route' : 'Directions'}</a>
              {place.website && <a className="button secondary compact" href={place.website}>{locale === 'de' ? 'Website' : 'Website'}</a>}
            </div>
          </details>
        </div>
      </article>)}
    </div>
  </>;
}
