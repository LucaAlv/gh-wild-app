import { getCollection, getEntry } from 'astro:content';

export async function allRooms() {
  return (await getCollection('rooms')).sort((left, right) => left.data.price - right.data.price);
}

export async function roomById(id: string) {
  const room = await getEntry('rooms', id);
  if (!room) throw new Error(`Missing room ${id}`);
  return room;
}

export async function pageById(id: string) {
  const page = await getEntry('pages', id);
  if (!page) throw new Error(`Missing page ${id}`);
  return page;
}

export async function legalById(id: string) {
  const document = await getEntry('legal', id);
  if (!document) throw new Error(`Missing legal document ${id}`);
  return document;
}

export async function settingById<T>(id: string): Promise<T> {
  const setting = await getEntry('settings', id);
  if (!setting) throw new Error(`Missing setting ${id}`);
  return setting.data as T;
}
