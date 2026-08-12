import type { ImageMetadata } from 'astro';

const modules = import.meta.glob<{ default: ImageMetadata }>('../assets/images/*.{jpg,png}', { eager: true });

const images = Object.fromEntries(
  Object.entries(modules).map(([file, module]) => [file.split('/').pop()?.replace(/\.(jpg|png)$/, ''), module.default]),
) as Record<string, ImageMetadata>;

export function imageAsset(name: string): ImageMetadata {
  const image = images[name];
  if (!image) throw new Error(`Missing image asset: ${name}`);
  return image;
}
