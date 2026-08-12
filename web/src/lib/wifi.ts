export function escapeWiFi(value: string): string {
  return value.replace(/([\\;,:\"])/g, '\\$1');
}

export function wifiPayload(ssid: string, password: string): string {
  return `WIFI:T:WPA;S:${escapeWiFi(ssid)};P:${escapeWiFi(password)};H:false;;`;
}
