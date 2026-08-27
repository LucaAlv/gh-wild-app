import { useEffect, useMemo, useRef, useState } from 'react';
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
  detailImageUrl?: string;
  travel: { minutes: number; mode: string; note?: { de: string; en: string } }[];
  openingHours?: { de: string; en: string };
  priceHint?: { de: string; en: string };
  familyNote?: { de: string; en: string };
  website?: string;
  phone?: string;
};

type Locale = 'de' | 'en';

const categoryCopy = {
  de: { all: 'Alle', food: 'Essen & Trinken', withKids: 'Mit Kindern', fair: 'Messe & Anreise', rainyDay: 'Bei Regen', shopping: 'Einkaufen', nature: 'Natur & Bewegung' },
  en: { all: 'All', food: 'Food & drink', withKids: 'With children', fair: 'Fair & transport', rainyDay: 'Rainy days', shopping: 'Shopping', nature: 'Nature & outdoors' },
};

// Short written labels instead of emoji: they localise, they stay legible at
// small sizes, and they match the rest of the page's typography.
const modeLabel = {
  de: { walk: 'zu Fuß', bike: 'Rad', car: 'Auto', transit: 'ÖPNV' },
  en: { walk: 'walk', bike: 'bike', car: 'car', transit: 'transit' },
} as const;

function travelLabel(mode: string, minutes: number, locale: Locale) {
  const label = modeLabel[locale][mode as keyof typeof modeLabel['de']] ?? mode;
  return locale === 'de' ? `${minutes} Min. ${label}` : `${minutes} min ${label}`;
}

export default function NearbyExplorer({ places, locale }: { places: Place[]; locale: Locale }) {
  const [category, setCategory] = useState('all');
  const [activeId, setActiveId] = useState<string | null>(null);
  const [shown, setShown] = useState<Place | null>(null);
  const dialogRef = useRef<HTMLDialogElement>(null);
  const copy = categoryCopy[locale];

  const results = useMemo(() => places
    .filter((place) => category === 'all' || place.categories.includes(category))
    .sort((left, right) => distanceInKilometres(left.latitude, left.longitude) - distanceInKilometres(right.latitude, right.longitude)), [places, category]);

  // `shown` lags `activeId` on close so the dialog still has content to animate out with.
  useEffect(() => {
    const dialog = dialogRef.current;
    if (!dialog) return;
    if (activeId && !dialog.open) dialog.showModal();
    if (!activeId && dialog.open) dialog.close();
    document.body.style.overflow = activeId ? 'hidden' : '';
    return () => { document.body.style.overflow = ''; };
  }, [activeId]);

  function open(place: Place) {
    setShown(place);
    setActiveId(place.id);
  }

  return <>
    <div className="filter-row" aria-label={locale === 'de' ? 'Kategorien' : 'Categories'}>
      {Object.entries(copy).map(([key, label]) => (
        <button className="chip" type="button" aria-pressed={category === key} onClick={() => setCategory(key)} key={key}>{label}</button>
      ))}
    </div>

    <p className="muted" aria-live="polite" style={{ fontSize: '.85rem', margin: '0 0 10px' }}>
      {locale === 'de' ? `${results.length} Orte` : `${results.length} places`}
    </p>

    <div className="place-grid">
      {results.map((place) => (
        <button
          className="place-card"
          type="button"
          key={place.id}
          onClick={() => open(place)}
          aria-haspopup="dialog"
        >
          <div className="place-media">
            {place.imageUrl
              ? <img src={place.imageUrl} alt="" loading="lazy" />
              : <span className="place-icon" aria-hidden="true">{place.name[locale].charAt(0)}</span>}
          </div>
          <div className="place-body">
            <p className="eyebrow">{formattedDistance(place.latitude, place.longitude, locale)}</p>
            <h3>{place.name[locale]}</h3>
            <p className="place-subtitle">{place.subtitle[locale]}</p>
            <div className="place-details">
              {place.travel.slice(0, 2).map((travel, index) => (
                <span className="tag" key={index}>{travelLabel(travel.mode, travel.minutes, locale)}</span>
              ))}
            </div>
          </div>
        </button>
      ))}
    </div>

    <dialog
      className="place-dialog"
      ref={dialogRef}
      aria-label={shown ? shown.name[locale] : undefined}
      onClose={() => setActiveId(null)}
      onClick={(event) => { if (event.target === event.currentTarget) setActiveId(null); }}
    >
      {shown && (
        <div className="dialog-scroll">
          <button
            className="dialog-close"
            type="button"
            onClick={() => setActiveId(null)}
            aria-label={locale === 'de' ? 'Schließen' : 'Close'}
          >×</button>
          {shown.detailImageUrl && <img className="dialog-image" src={shown.detailImageUrl} alt="" />}
          <div className="dialog-body">
            <p className="eyebrow">{formattedDistance(shown.latitude, shown.longitude, locale)}</p>
            <h2>{shown.name[locale]}</h2>
            <p className="muted">{shown.subtitle[locale]}</p>
            <div className="place-details">
              {shown.travel.map((travel, index) => (
                <span className="tag" key={index}>{travelLabel(travel.mode, travel.minutes, locale)}</span>
              ))}
            </div>
            <p>{shown.description[locale]}</p>
            <div className="dialog-facts">
              {shown.openingHours && <p><strong>{locale === 'de' ? 'Öffnung: ' : 'Hours: '}</strong>{shown.openingHours[locale]}</p>}
              {shown.priceHint && <p><strong>{locale === 'de' ? 'Preis: ' : 'Price: '}</strong>{shown.priceHint[locale]}</p>}
              {shown.familyNote && <p><strong>{locale === 'de' ? 'Unser Tipp: ' : 'Our tip: '}</strong>{shown.familyNote[locale]}</p>}
            </div>
            <div className="guide-actions">
              <a className="button secondary compact" href={`https://maps.apple.com/?daddr=${shown.latitude},${shown.longitude}`}>
                {locale === 'de' ? 'Route' : 'Directions'}
              </a>
              {shown.website && (
                <a className="button secondary compact" href={shown.website} target="_blank" rel="noreferrer">
                  {locale === 'de' ? 'Website' : 'Website'}
                </a>
              )}
              {shown.phone && <a className="button secondary compact" href={`tel:${shown.phone}`}>{locale === 'de' ? 'Anrufen' : 'Call'}</a>}
            </div>
          </div>
        </div>
      )}
    </dialog>
  </>;
}
