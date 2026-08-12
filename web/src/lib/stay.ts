export type Stay = { arrival: string; departure: string; roomId?: string };

export type StayPhase =
  | { kind: 'notSet' }
  | { kind: 'upcoming'; daysUntilArrival: number }
  | { kind: 'arrivalDay' }
  | { kind: 'inHouse'; nightsRemaining: number }
  | { kind: 'departureDay' }
  | { kind: 'past'; daysSinceDeparture: number };

const DATE_PATTERN = /^\d{4}-\d{2}-\d{2}$/;

export function isDateString(value: unknown): value is string {
  if (typeof value !== 'string' || !DATE_PATTERN.test(value)) return false;
  const [year, month, day] = value.split('-').map(Number);
  const date = new Date(Date.UTC(year, month - 1, day));
  return date.getUTCFullYear() === year && date.getUTCMonth() === month - 1 && date.getUTCDate() === day;
}

function ordinal(value: string): number {
  if (!isDateString(value)) throw new Error(`Invalid calendar date: ${value}`);
  const [year, month, day] = value.split('-').map(Number);
  return Date.UTC(year, month - 1, day) / 86_400_000;
}

export function addDays(value: string, days: number): string {
  const date = new Date((ordinal(value) + days) * 86_400_000);
  return date.toISOString().slice(0, 10);
}

export function nights(from: string, to: string): number {
  return ordinal(to) - ordinal(from);
}

export function berlinToday(now = new Date()): string {
  const parts = new Intl.DateTimeFormat('en-CA', {
    timeZone: 'Europe/Berlin', year: 'numeric', month: '2-digit', day: '2-digit',
  }).formatToParts(now);
  const find = (type: Intl.DateTimeFormatPartTypes) => parts.find((part) => part.type === type)?.value ?? '';
  return `${find('year')}-${find('month')}-${find('day')}`;
}

export function phaseFor(stay: Stay | null, today = berlinToday()): StayPhase {
  if (!stay) return { kind: 'notSet' };
  if (today < stay.arrival) return { kind: 'upcoming', daysUntilArrival: Math.max(0, nights(today, stay.arrival)) };
  if (today === stay.arrival) return { kind: 'arrivalDay' };
  if (today < stay.departure) return { kind: 'inHouse', nightsRemaining: Math.max(1, nights(today, stay.departure)) };
  if (today === stay.departure) return { kind: 'departureDay' };
  return { kind: 'past', daysSinceDeparture: Math.max(0, nights(stay.departure, today)) };
}

export function isStale(stay: Stay, today = berlinToday()): boolean {
  return today > stay.departure && nights(stay.departure, today) > 14;
}

export function normalizeStay(stay: Stay): Stay {
  if (!isDateString(stay.arrival) || !isDateString(stay.departure)) throw new Error('Invalid stay dates');
  return { ...stay, departure: stay.departure <= stay.arrival ? addDays(stay.arrival, 1) : stay.departure };
}

export function readStay(storage: Pick<Storage, 'getItem' | 'removeItem'>): Stay | null {
  try {
    const raw = storage.getItem('gaestehaus-wild.stay');
    if (!raw) return null;
    const parsed = JSON.parse(raw) as Stay;
    const stay = normalizeStay(parsed);
    if (isStale(stay)) {
      storage.removeItem('gaestehaus-wild.stay');
      return null;
    }
    return stay;
  } catch {
    storage.removeItem('gaestehaus-wild.stay');
    return null;
  }
}
