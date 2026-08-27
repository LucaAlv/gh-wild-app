import { useEffect, useState } from 'react';

type GalleryImage = { thumbnail: string; full: string; alt: string };

export default function GalleryLightbox({ images, closeLabel }: { images: GalleryImage[]; closeLabel: string }) {
  const [active, setActive] = useState<number | null>(null);
  // Kept so the overlay still has an image to fade out with after `active` clears.
  const [last, setLast] = useState(0);
  const shown = active ?? last;

  useEffect(() => {
    if (active === null) return;
    const handler = (event: KeyboardEvent) => {
      if (event.key === 'Escape') setActive(null);
      if (event.key === 'ArrowRight') setActive((active + 1) % images.length);
      if (event.key === 'ArrowLeft') setActive((active - 1 + images.length) % images.length);
    };
    window.addEventListener('keydown', handler);
    document.body.style.overflow = 'hidden';
    return () => {
      window.removeEventListener('keydown', handler);
      document.body.style.overflow = '';
    };
  }, [active, images.length]);

  function open(index: number) {
    setLast(index);
    setActive(index);
  }

  function step(offset: number) {
    if (active === null) return;
    const next = (active + offset + images.length) % images.length;
    setLast(next);
    setActive(next);
  }

  return <>
    <div className="gallery-grid">
      {images.map((image, index) => (
        <button className="gallery-button" type="button" onClick={() => open(index)} key={image.thumbnail} aria-label={image.alt}>
          <img src={image.thumbnail} alt={image.alt} loading={index < 4 ? 'eager' : 'lazy'} />
        </button>
      ))}
    </div>
    <div
      className="lightbox"
      data-open={active !== null}
      inert={active === null}
      role="dialog"
      aria-modal="true"
      aria-label={active === null ? undefined : images[active].alt}
      onClick={(event) => event.target === event.currentTarget && setActive(null)}
    >
      {images[shown] && <img src={images[shown].full} alt={images[shown].alt} />}
      <button className="lightbox-close" type="button" onClick={() => setActive(null)} aria-label={closeLabel}>×</button>
      <button className="lightbox-prev" type="button" onClick={() => step(-1)} aria-label="Previous">‹</button>
      <button className="lightbox-next" type="button" onClick={() => step(1)} aria-label="Next">›</button>
    </div>
  </>;
}
