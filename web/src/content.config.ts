import { defineCollection } from 'astro:content';
import { glob } from 'astro/loaders';
import { z } from 'astro/zod';

const localized = z.object({
  de: z.string().trim().min(1),
  en: z.string().trim().min(1),
});

const rooms = defineCollection({
  loader: glob({ base: './src/content/rooms', pattern: '**/*.yaml' }),
  schema: z.object({
    name: localized,
    price: z.number().int().positive(),
    occupancy: localized,
    description: localized,
    images: z.array(z.string().min(1)).min(1),
  }),
});

const guide = defineCollection({
  loader: glob({ base: './src/content/guide', pattern: '**/*.yaml' }),
  schema: z.object({
    symbol: z.string().min(1),
    title: localized,
    answer: localized,
    keywords: z.array(z.string()),
    category: z.enum(['emergency', 'room', 'house', 'food', 'practical', 'departure']),
    actions: z.array(z.object({
      type: z.enum(['call', 'map', 'link', 'page']),
      target: z.string().min(1),
    })),
    needsOwnerReview: z.boolean().default(false),
  }),
});

const nearby = defineCollection({
  loader: glob({ base: './src/content/nearby', pattern: '**/*.yaml' }),
  schema: z.object({
    name: localized,
    subtitle: localized,
    description: localized,
    latitude: z.number(),
    longitude: z.number(),
    categories: z.array(z.enum(['food', 'withKids', 'fair', 'rainyDay', 'shopping', 'nature'])).min(1),
    image: z.string().optional(),
    travel: z.array(z.object({
      minutes: z.number().int().positive(),
      mode: z.enum(['walk', 'bike', 'car', 'transit']),
      note: localized.optional(),
    })).min(1),
    openingHours: localized.optional(),
    priceHint: localized.optional(),
    familyNote: localized.optional(),
    website: z.url().optional(),
    phone: z.string().optional(),
  }),
});

const arrival = defineCollection({
  loader: glob({ base: './src/content/arrival', pattern: '**/*.yaml' }),
  schema: z.object({
    destination: localized,
    symbol: z.string().min(1),
    durationSummary: localized,
    steps: z.array(localized).min(1),
    tip: localized.optional(),
  }),
});

const pages = defineCollection({
  loader: glob({ base: './src/content/pages', pattern: '**/*.yaml' }),
  schema: z.object({
    title: localized,
    eyebrow: localized.optional(),
    intro: localized,
    body: localized.optional(),
    options: z.array(localized).optional(),
    testimonials: z.array(localized).optional(),
    image: z.string().optional(),
  }),
});

const legal = defineCollection({
  loader: glob({ base: './src/content/legal', pattern: '**/*.yaml' }),
  schema: z.object({
    title: localized,
    body: localized,
    needsOwnerReview: z.boolean(),
  }),
});

const settings = defineCollection({
  loader: glob({ base: './src/content/settings', pattern: '**/*.yaml' }),
  schema: z.record(z.string(), z.unknown()),
});

export const collections = { rooms, guide, nearby, arrival, pages, legal, settings };
