import { useEffect, useState } from 'react';

type GalleryImage = { thumbnail: string; full: string; alt: string };

export default function GalleryLightbox({ images, closeLabel }: { images: GalleryImage[]; closeLabel: string }) {
  const [active, setActive] = useState<number | null>(null);
  useEffect(() => {
    const handler = (event: KeyboardEvent) => {
      if (active === null) return;
      if (event.key === 'Escape') setActive(null);
      if (event.key === 'ArrowRight') setActive((active + 1) % images.length);
      if (event.key === 'ArrowLeft') setActive((active - 1 + images.length) % images.length);
    };
    window.addEventListener('keydown', handler);
    return () => window.removeEventListener('keydown', handler);
  }, [active, images.length]);

  return <>
    <div className="gallery-grid">
      {images.map((image, index) => <button className="gallery-button" type="button" onClick={() => setActive(index)} key={image.thumbnail} aria-label={image.alt}>
        <img src={image.thumbnail} alt={image.alt} loading={index < 4 ? 'eager' : 'lazy'} />
      </button>)}
    </div>
    <div className="lightbox" hidden={active === null} role="dialog" aria-modal="true" aria-label={active === null ? '' : images[active].alt} onClick={(event) => event.target === event.currentTarget && setActive(null)}>
      {active !== null && <img src={images[active].full} alt={images[active].alt} />}
      <button className="lightbox-close" type="button" onClick={() => setActive(null)} aria-label={closeLabel}>×</button>
      <button className="lightbox-prev" type="button" onClick={() => active !== null && setActive((active - 1 + images.length) % images.length)} aria-label="Previous">‹</button>
      <button className="lightbox-next" type="button" onClick={() => active !== null && setActive((active + 1) % images.length)} aria-label="Next">›</button>
    </div>
  </>;
}
