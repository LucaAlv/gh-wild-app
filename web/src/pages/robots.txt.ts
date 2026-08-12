import type { APIRoute } from 'astro';

export const GET: APIRoute = () => {
  const live = import.meta.env.PUBLIC_SITE_LIVE === 'true';
  const body = live
    ? `User-agent: *\nAllow: /\nDisallow: /gast\nDisallow: /en/guest\nDisallow: /admin\n\nSitemap: https://www.gaestehaus-wild.com/sitemap-index.xml\n`
    : 'User-agent: *\nDisallow: /\n';
  return new Response(body, { headers: { 'Content-Type': 'text/plain; charset=utf-8' } });
};
