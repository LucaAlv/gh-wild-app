import type { IncomingMessage, ServerResponse } from 'node:http';
import { z } from 'zod';

type Request = IncomingMessage & { body?: unknown };

const inquirySchema = z.object({
  firstName: z.string().trim().min(1).max(100),
  lastName: z.string().trim().min(1).max(100),
  phone: z.string().trim().max(50).optional().default(''),
  email: z.email().trim().max(254),
  roomCategory: z.enum(['single', 'double', 'triple', 'family', 'family2', 'quad', 'basement']),
  arrival: z.iso.date(),
  departure: z.iso.date(),
  adults: z.coerce.number().int().min(1).max(30).default(1),
  children: z.coerce.number().int().min(0).max(20).default(0),
  message: z.string().trim().max(5000).optional().default(''),
  consent: z.literal('yes'),
  language: z.enum(['de', 'en']).default('de'),
  website: z.string().max(0).optional().default(''),
  'cf-turnstile-response': z.string().min(1),
}).refine((value) => value.departure > value.arrival, { message: 'Departure must be after arrival' });

const attempts = new Map<string, number[]>();

function rateLimited(ip: string, now = Date.now()): boolean {
  const period = 60 * 60 * 1000;
  const recent = (attempts.get(ip) ?? []).filter((timestamp) => now - timestamp < period);
  recent.push(now);
  attempts.set(ip, recent);
  return recent.length > 5;
}

function bodyOf(request: Request): Record<string, unknown> {
  if (request.body && typeof request.body === 'object') return request.body as Record<string, unknown>;
  if (typeof request.body === 'string') return Object.fromEntries(new URLSearchParams(request.body));
  return {};
}

function redirect(response: ServerResponse, location: string) {
  response.statusCode = 303;
  response.setHeader('Location', location);
  response.end();
}

function escapeHTML(value: string): string {
  return value.replace(/[&<>"']/g, (character) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' })[character]!);
}

export default async function handler(request: Request, response: ServerResponse) {
  if (request.method !== 'POST') {
    response.statusCode = 405;
    response.setHeader('Allow', 'POST');
    return response.end('Method not allowed');
  }

  const raw = bodyOf(request);
  const language = raw.language === 'en' ? 'en' : 'de';
  const errorLocation = language === 'en' ? '/en/inquiry?error=1' : '/anfrage?error=1';
  const successLocation = language === 'en' ? '/en/thank-you' : '/vielen-dank';

  if (typeof raw.website === 'string' && raw.website.length > 0) return redirect(response, successLocation);

  const ip = String(request.headers['x-forwarded-for'] ?? request.socket.remoteAddress ?? 'unknown').split(',')[0].trim();
  if (rateLimited(ip)) {
    response.statusCode = 429;
    return response.end('Too many requests');
  }

  const parsed = inquirySchema.safeParse(raw);
  if (!parsed.success) return redirect(response, errorLocation);
  const inquiry = parsed.data;

  const turnstileSecret = process.env.TURNSTILE_SECRET_KEY;
  const resendKey = process.env.RESEND_API_KEY;
  if (!turnstileSecret || !resendKey) {
    response.statusCode = 503;
    return response.end('Form service is not configured');
  }

  const verification = await fetch('https://challenges.cloudflare.com/turnstile/v0/siteverify', {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: new URLSearchParams({ secret: turnstileSecret, response: inquiry['cf-turnstile-response'], remoteip: ip }),
  });
  const verificationResult = await verification.json() as { success?: boolean };
  if (!verificationResult.success) return redirect(response, errorLocation);

  const roomNames: Record<string, string> = {
    single: 'Einzelzimmer', double: 'Doppelzimmer', triple: 'Dreibettzimmer', family: 'Familienzimmer',
    family2: 'Familienzimmer 2', quad: 'Vierbettzimmer', basement: 'Souterrain Zimmer',
  };
  const lines = [
    ['Name', `${inquiry.firstName} ${inquiry.lastName}`], ['E-Mail', inquiry.email], ['Telefon', inquiry.phone || '—'],
    ['Zimmer', roomNames[inquiry.roomCategory]], ['Anreise', inquiry.arrival], ['Abreise', inquiry.departure],
    ['Erwachsene', String(inquiry.adults)], ['Kinder', String(inquiry.children)], ['Nachricht', inquiry.message || '—'],
  ];
  const html = `<h1>Neue Anfrage über gaestehaus-wild.com</h1><table>${lines.map(([label, value]) => `<tr><th align="left" valign="top">${escapeHTML(label)}</th><td>${escapeHTML(value).replace(/\n/g, '<br>')}</td></tr>`).join('')}</table>`;

  const sent = await fetch('https://api.resend.com/emails', {
    method: 'POST',
    headers: { Authorization: `Bearer ${resendKey}`, 'Content-Type': 'application/json' },
    body: JSON.stringify({
      from: process.env.INQUIRY_FROM_EMAIL ?? 'Gästehaus Wild <anfrage@send.gaestehaus-wild.com>',
      to: [process.env.INQUIRY_TO_EMAIL ?? 'info@gaestehaus-wild.com'],
      reply_to: inquiry.email,
      subject: `Anfrage ${inquiry.arrival} – ${inquiry.firstName} ${inquiry.lastName}`,
      html,
    }),
  });
  if (!sent.ok) {
    console.error('Resend request failed', sent.status);
    return redirect(response, errorLocation);
  }
  return redirect(response, successLocation);
}
