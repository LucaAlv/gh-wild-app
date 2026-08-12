/// <reference types="astro/client" />

interface ImportMetaEnv {
  readonly PUBLIC_TURNSTILE_SITE_KEY?: string;
  readonly PUBLIC_SITE_LIVE?: string;
}

interface ImportMeta {
  readonly env: ImportMetaEnv;
}
