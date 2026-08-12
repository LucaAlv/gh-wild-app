export type BreakfastWindow = { start: string; end: string };
export type BreakfastState =
  | { kind: 'opensToday'; at: string }
  | { kind: 'openNow'; until: string }
  | { kind: 'closedUntil'; nextDate: string; at: string };

import { addDays, berlinToday } from './stay';

function berlinTime(now: Date): string {
  return new Intl.DateTimeFormat('en-GB', {
    timeZone: 'Europe/Berlin', hour: '2-digit', minute: '2-digit', hourCycle: 'h23',
  }).format(now);
}

function isSunday(date: string): boolean {
  return new Date(`${date}T12:00:00Z`).getUTCDay() === 0;
}

export function breakfastState(
  now: Date,
  weekday: BreakfastWindow,
  sunday: BreakfastWindow,
): BreakfastState {
  const today = berlinToday(now);
  const time = berlinTime(now);
  const window = isSunday(today) ? sunday : weekday;
  if (time < window.start) return { kind: 'opensToday', at: window.start };
  if (time < window.end) return { kind: 'openNow', until: window.end };
  const tomorrow = addDays(today, 1);
  return { kind: 'closedUntil', nextDate: tomorrow, at: (isSunday(tomorrow) ? sunday : weekday).start };
}
