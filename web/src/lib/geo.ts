const GUESTHOUSE = { latitude: 49.4224662, longitude: 10.9807374 };

const radians = (degrees: number) => degrees * Math.PI / 180;

export function distanceInKilometres(latitude: number, longitude: number): number {
  const earthRadius = 6371;
  const latitudeDelta = radians(latitude - GUESTHOUSE.latitude);
  const longitudeDelta = radians(longitude - GUESTHOUSE.longitude);
  const a = Math.sin(latitudeDelta / 2) ** 2
    + Math.cos(radians(GUESTHOUSE.latitude)) * Math.cos(radians(latitude)) * Math.sin(longitudeDelta / 2) ** 2;
  return earthRadius * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
}

export function formattedDistance(latitude: number, longitude: number, locale: 'de' | 'en'): string {
  const distance = distanceInKilometres(latitude, longitude);
  const digits = distance < 10 ? 1 : 0;
  const number = new Intl.NumberFormat(locale === 'de' ? 'de-DE' : 'en-GB', {
    minimumFractionDigits: digits, maximumFractionDigits: digits,
  }).format(distance);
  return locale === 'de' ? `${number} km Luftlinie` : `${number} km straight-line`;
}
