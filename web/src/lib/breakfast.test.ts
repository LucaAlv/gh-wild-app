import { describe, expect, it } from 'vitest';
import { breakfastState } from './breakfast';

const weekday = { start: '07:00', end: '10:00' };
const sunday = { start: '08:00', end: '10:00' };

describe('breakfast window', () => {
  it('handles before, during and after breakfast', () => {
    expect(breakfastState(new Date('2026-08-03T04:30:00Z'), weekday, sunday)).toEqual({ kind: 'opensToday', at: '07:00' });
    expect(breakfastState(new Date('2026-08-03T06:15:00Z'), weekday, sunday)).toEqual({ kind: 'openNow', until: '10:00' });
    expect(breakfastState(new Date('2026-08-03T08:30:00Z'), weekday, sunday)).toEqual({ kind: 'closedUntil', nextDate: '2026-08-04', at: '07:00' });
  });

  it('uses the later Sunday opening', () => {
    expect(breakfastState(new Date('2026-08-02T05:30:00Z'), weekday, sunday)).toEqual({ kind: 'opensToday', at: '08:00' });
  });

  it('rolls Saturday after closing into Sunday', () => {
    expect(breakfastState(new Date('2026-08-01T08:30:00Z'), weekday, sunday)).toEqual({ kind: 'closedUntil', nextDate: '2026-08-02', at: '08:00' });
  });
});
