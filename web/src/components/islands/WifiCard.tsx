import { useEffect, useRef, useState } from 'react';
import QRCode from 'qrcode';
import { wifiPayload } from '../../lib/wifi';

export default function WifiCard({ ssid, password, locale }: { ssid: string; password: string | null; locale: 'de' | 'en' }) {
  const canvas = useRef<HTMLCanvasElement>(null);
  const [copied, setCopied] = useState(false);
  useEffect(() => {
    if (password && canvas.current) QRCode.toCanvas(canvas.current, wifiPayload(ssid, password), { width: 420, margin: 2, color: { dark: '#080808', light: '#fffdf9' } });
  }, [ssid, password]);

  if (!password) return <div className="paper-panel notice warning">
    <h3>{locale === 'de' ? 'WLAN-Zugang folgt' : 'Wi-Fi access coming soon'}</h3>
    <p>{locale === 'de' ? 'Das Passwort für das isolierte Gastnetz wird vor der Veröffentlichung von der Familie bestätigt. Bitte fragen Sie uns bis dahin persönlich.' : 'The isolated guest-network password will be confirmed by the family before publication. Until then, please ask us in person.'}</p>
  </div>;

  return <div className="paper-panel wifi-panel">
    <div>
      <p className="eyebrow">{locale === 'de' ? 'Kostenloses Gast-WLAN' : 'Free guest Wi-Fi'}</p>
      <h3>{ssid}</h3>
      <p className="secret">{password}</p>
      <button className="button secondary compact" type="button" onClick={async () => {
        await navigator.clipboard.writeText(password);
        setCopied(true);
        window.setTimeout(() => setCopied(false), 2000);
      }}>{copied ? (locale === 'de' ? 'Kopiert ✓' : 'Copied ✓') : (locale === 'de' ? 'Passwort kopieren' : 'Copy password')}</button>
    </div>
    <canvas ref={canvas} aria-label={locale === 'de' ? `QR-Code für ${ssid}` : `QR code for ${ssid}`} />
  </div>;
}
