import { describe, expect, it } from 'vitest';
import { createCalendar, reminderSchedule } from './ics';

describe('calendar reminders', () => {
  it('creates welcome, breakfasts, checkout and thanks', () => {
    const reminders = reminderSchedule({ arrival: '2026-08-10', departure: '2026-08-13' });
    expect(reminders.map(({ id }) => id)).toEqual([
      'stay.welcome', 'stay.breakfast.0', 'stay.breakfast.1', 'stay.breakfast.2', 'stay.checkout', 'stay.thanks',
    ]);
    expect(reminders[1]).toMatchObject({ date: '2026-08-11', time: '07:45' });
    expect(reminders[4]).toMatchObject({ date: '2026-08-12', time: '19:00' });
    expect(reminders[5]).toMatchObject({ date: '2026-08-14', time: '11:00' });
  });

  it('limits breakfast reminders to fourteen', () => {
    const reminders = reminderSchedule({ arrival: '2026-08-10', departure: '2026-08-30' });
    expect(reminders.filter(({ kind }) => kind === 'breakfast')).toHaveLength(14);
  });

  it('emits Berlin calendar events with alarms', () => {
    const calendar = createCalendar({ arrival: '2026-08-10', departure: '2026-08-11' }, 'de');
    expect(calendar).toContain('DTSTART;TZID=Europe/Berlin:20260810T130000');
    expect(calendar).toContain('BEGIN:VALARM');
  });
});
