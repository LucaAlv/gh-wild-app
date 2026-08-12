import { describe, expect, it } from 'vitest';
import { addDays, isStale, nights, normalizeStay, phaseFor } from './stay';

describe('stay calendar', () => {
  const stay = { arrival: '2026-08-10', departure: '2026-08-13' };

  it('switches phases at Berlin calendar-day boundaries', () => {
    expect(phaseFor(stay, '2026-08-09')).toEqual({ kind: 'upcoming', daysUntilArrival: 1 });
    expect(phaseFor(stay, '2026-08-10')).toEqual({ kind: 'arrivalDay' });
    expect(phaseFor(stay, '2026-08-11')).toEqual({ kind: 'inHouse', nightsRemaining: 2 });
    expect(phaseFor(stay, '2026-08-13')).toEqual({ kind: 'departureDay' });
    expect(phaseFor(stay, '2026-08-14')).toEqual({ kind: 'past', daysSinceDeparture: 1 });
  });

  it('counts nights through both German DST changes', () => {
    expect(nights('2026-03-28', '2026-03-30')).toBe(2);
    expect(nights('2026-10-24', '2026-10-26')).toBe(2);
  });

  it('clamps a same-day departure to one night', () => {
    expect(normalizeStay({ arrival: '2026-08-10', departure: '2026-08-10' }).departure).toBe('2026-08-11');
  });

  it('expires only after fourteen days', () => {
    expect(isStale(stay, '2026-08-27')).toBe(false);
    expect(isStale(stay, '2026-08-28')).toBe(true);
  });

  it('adds civil days without DST drift', () => {
    expect(addDays('2026-03-28', 2)).toBe('2026-03-30');
  });
});
