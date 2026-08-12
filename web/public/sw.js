const VERSION = 'gw-v1';
const CRITICAL_CACHE = `${VERSION}-critical`;
const RUNTIME_CACHE = `${VERSION}-runtime`;
const PRECACHE_ASSETS = [/* INJECT_ASSETS */];
const CRITICAL_ROUTES = [
  '/', '/gast', '/gaestemappe', '/anreise', '/mein-aufenthalt', '/kontakt',
  '/en', '/en/guest', '/en/house-guide', '/en/getting-here', '/en/my-stay', '/en/contact',
  '/manifest.webmanifest',
];

self.addEventListener('install', (event) => {
  event.waitUntil(caches.open(CRITICAL_CACHE).then((cache) => cache.addAll([...CRITICAL_ROUTES, ...PRECACHE_ASSETS])).then(() => self.skipWaiting()));
});

self.addEventListener('activate', (event) => {
  event.waitUntil(caches.keys().then((keys) => Promise.all(keys.filter((key) => !key.startsWith(VERSION)).map((key) => caches.delete(key)))).then(() => self.clients.claim()));
});

self.addEventListener('fetch', (event) => {
  const request = event.request;
  if (request.method !== 'GET') return;
  const url = new URL(request.url);
  if (url.origin !== self.location.origin || url.pathname.startsWith('/api/') || url.pathname.startsWith('/admin')) return;

  if (url.pathname.startsWith('/_astro/')) {
    event.respondWith(caches.match(request).then((cached) => cached || fetch(request).then((response) => {
      if (response.ok) caches.open(CRITICAL_CACHE).then((cache) => cache.put(request, response.clone()));
      return response;
    })));
    return;
  }

  if (request.destination === 'image') {
    event.respondWith(caches.open(RUNTIME_CACHE).then(async (cache) => {
      const cached = await cache.match(request);
      if (cached) return cached;
      const response = await fetch(request);
      if (response.ok) cache.put(request, response.clone());
      return response;
    }));
    return;
  }

  if (CRITICAL_ROUTES.includes(url.pathname)) {
    event.respondWith(caches.match(request).then((cached) => cached || fetch(request).then((response) => {
      if (response.ok) caches.open(CRITICAL_CACHE).then((cache) => cache.put(request, response.clone()));
      return response;
    })));
    return;
  }

  if (request.mode === 'navigate') {
    event.respondWith(fetch(request).then((response) => {
      if (response.ok) caches.open(RUNTIME_CACHE).then((cache) => cache.put(request, response.clone()));
      return response;
    }).catch(() => caches.match(request).then((cached) => cached || caches.match('/'))));
  }
});
