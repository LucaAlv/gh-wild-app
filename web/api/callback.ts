import { createHmac, timingSafeEqual } from 'node:crypto';
import type { IncomingMessage, ServerResponse } from 'node:http';

function signature(value: string, secret: string) {
  return createHmac('sha256', secret).update(value).digest('hex');
}

function output(response: ServerResponse, token?: string, error?: string) {
  const state = error ? 'error' : 'success';
  const content = error ? { provider: 'github', error } : { provider: 'github', token };
  const message = JSON.stringify(`authorization:github:${state}:${JSON.stringify(content)}`);
  response.statusCode = 200;
  response.setHeader('Content-Type', 'text/html; charset=utf-8');
  response.setHeader('Cache-Control', 'no-store');
  response.setHeader('Set-Cookie', '__Host-cms-oauth=deleted; HttpOnly; Path=/; Max-Age=0; SameSite=Lax; Secure');
  response.end(`<!doctype html><html><body><script>(()=>{window.addEventListener('message',({data,origin})=>{if(data==='authorizing:github')window.opener?.postMessage(${message},origin)});window.opener?.postMessage('authorizing:github','*')})()</script></body></html>`);
}

export default async function handler(request: IncomingMessage, response: ServerResponse) {
  const clientId = process.env.GITHUB_OAUTH_CLIENT_ID;
  const clientSecret = process.env.GITHUB_OAUTH_CLIENT_SECRET;
  const cookieSecret = process.env.OAUTH_COOKIE_SECRET;
  if (!clientId || !clientSecret || !cookieSecret) return output(response, undefined, 'OAuth is not configured');

  const url = new URL(request.url ?? '/api/callback', `https://${request.headers.host}`);
  const code = url.searchParams.get('code');
  const state = url.searchParams.get('state');
  const cookieValue = request.headers.cookie?.match(/(?:^|;\s*)__Host-cms-oauth=([^;]+)/)?.[1];
  const [nonce, receivedSignature] = cookieValue?.split('.') ?? [];
  if (!code || !state || !nonce || !receivedSignature || state !== nonce) return output(response, undefined, 'Potential CSRF attack detected');
  const expectedSignature = signature(nonce, cookieSecret);
  if (receivedSignature.length !== expectedSignature.length || !timingSafeEqual(Buffer.from(receivedSignature), Buffer.from(expectedSignature))) {
    return output(response, undefined, 'Potential CSRF attack detected');
  }

  try {
    const tokenResponse = await fetch('https://github.com/login/oauth/access_token', {
      method: 'POST',
      headers: { Accept: 'application/json', 'Content-Type': 'application/json' },
      body: JSON.stringify({ client_id: clientId, client_secret: clientSecret, code }),
    });
    const result = await tokenResponse.json() as { access_token?: string; error?: string };
    return output(response, result.access_token, result.error || (!result.access_token ? 'Token request failed' : undefined));
  } catch {
    return output(response, undefined, 'Token request failed');
  }
}
