import { createHmac, randomBytes } from 'node:crypto';
import type { IncomingMessage, ServerResponse } from 'node:http';

function signature(value: string, secret: string) {
  return createHmac('sha256', secret).update(value).digest('hex');
}

export default function handler(request: IncomingMessage, response: ServerResponse) {
  const clientId = process.env.GITHUB_OAUTH_CLIENT_ID;
  const cookieSecret = process.env.OAUTH_COOKIE_SECRET;
  if (!clientId || !process.env.GITHUB_OAUTH_CLIENT_SECRET || !cookieSecret) {
    response.statusCode = 503;
    return response.end('GitHub OAuth is not configured');
  }
  const url = new URL(request.url ?? '/api/auth', `https://${request.headers.host}`);
  if (url.searchParams.get('provider') !== 'github') {
    response.statusCode = 400;
    return response.end('Unsupported provider');
  }
  const nonce = randomBytes(16).toString('hex');
  const cookie = `${nonce}.${signature(nonce, cookieSecret)}`;
  const parameters = new URLSearchParams({ client_id: clientId, scope: 'repo,user', state: nonce });
  response.statusCode = 302;
  response.setHeader('Location', `https://github.com/login/oauth/authorize?${parameters}`);
  response.setHeader('Set-Cookie', `__Host-cms-oauth=${cookie}; HttpOnly; Path=/; Max-Age=600; SameSite=Lax; Secure`);
  response.end();
}
