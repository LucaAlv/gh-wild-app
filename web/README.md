# Gästehaus Wild website

The bilingual Astro site replaces the Wix website and ports the frozen iOS guest companion to the browser. German keeps the legacy root URLs; English lives under `/en/`.

## Local development

Requires Node.js 22 or newer.

```bash
npm install
npm run dev
```

Before committing, run:

```bash
npm test
npm run check
npm run build
```

`npm run build` validates all content, builds the static site, optimizes images, and injects the guest-critical application assets into the offline service-worker cache.

## Architecture

- `src/content/`: Git-backed bilingual content edited by Sveltia CMS.
- `src/pages/` and `src/components/`: static Astro routes and shared presentation.
- `src/components/islands/`: the few browser interactions (guide search, nearby filters, stay planner, gallery, Wi-Fi QR).
- `src/lib/`: pure stay, search, geo, breakfast, Wi-Fi, and calendar logic with Vitest coverage.
- `api/`: Vercel functions for inquiries and GitHub OAuth.
- `public/admin/`: Sveltia CMS dashboard and configuration.

The Vercel project root must be `web`. Preview builds default to `noindex`; only set `PUBLIC_SITE_LIVE=true` for the approved production launch.

## Preview deployment setup

1. Import the repository into Vercel with project root `web` and enable Deployment Protection before sharing the URL.
2. Add the variables listed in `.env.example`. Keep every variable without a `PUBLIC_` prefix server-only.
3. Create a Cloudflare Turnstile widget for the protected preview domain and production domain.
4. Verify `send.gaestehaus-wild.com` in Resend. Do not add a second SPF record to the root domain and do not change Microsoft 365 MX records.
5. Register a GitHub OAuth App whose callback is `https://<preview-or-production-host>/api/callback`, then add its client credentials to Vercel.

## Deliberate launch gates

The preview is complete without inventing owner information. Public launch remains blocked until:

- the isolated guest Wi-Fi and password are confirmed;
- ten guide entries marked `needsOwnerReview` have specific approved answers;
- Impressum, Datenschutz and AGB (including the English convenience translations) are legally approved;
- the VAT-number question and breakfast-on-public-holidays rule are resolved;
- the inquiry delivery, CMS login, offline guest flow and printed QR are tested on a real iPhone.

See `CONTENT-EDITING.md` for the owner-facing editing workflow.
