import { addDays, nights, type Stay } from './stay';

export type ReminderKind = 'welcome' | 'breakfast' | 'checkout' | 'thanks';
export type Reminder = { id: string; date: string; time: string; kind: ReminderKind };

export function reminderSchedule(stay: Stay): Reminder[] {
  const reminders: Reminder[] = [
    { id: 'stay.welcome', date: stay.arrival, time: '13:00', kind: 'welcome' },
  ];
  const nightCount = Math.max(0, nights(stay.arrival, stay.departure));
  for (let offset = 0; offset < Math.min(nightCount, 14); offset += 1) {
    reminders.push({
      id: `stay.breakfast.${offset}`,
      date: addDays(stay.arrival, offset + 1),
      time: '07:45',
      kind: 'breakfast',
    });
  }
  reminders.push(
    { id: 'stay.checkout', date: addDays(stay.departure, -1), time: '19:00', kind: 'checkout' },
    { id: 'stay.thanks', date: addDays(stay.departure, 1), time: '11:00', kind: 'thanks' },
  );
  return reminders;
}

function escapeICS(value: string): string {
  return value.replace(/\\/g, '\\\\').replace(/;/g, '\\;').replace(/,/g, '\\,').replace(/\n/g, '\\n');
}

function localDateTime(date: string, time: string): string {
  return `${date.replaceAll('-', '')}T${time.replace(':', '')}00`;
}

export function createCalendar(stay: Stay, locale: 'de' | 'en'): string {
  const copy = locale === 'de' ? {
    welcome: ['Willkommen im Gästehaus Wild', 'Check-in ist ab 15:00 Uhr.'],
    breakfast: ['Guten Morgen', 'Das Frühstück ist für Sie bereit – noch bis 10:00 Uhr.'],
    checkout: ['Morgen ist Abreise', 'Check-out ist morgen bis 11:00 Uhr.'],
    thanks: ['Danke für Ihren Besuch', 'Wir hoffen, Sie hatten eine gute Zeit.'],
  } : {
    welcome: ['Welcome to Gästehaus Wild', 'Check-in starts at 3:00 pm.'],
    breakfast: ['Good morning', 'Breakfast is ready—until 10:00 am.'],
    checkout: ['Check-out is tomorrow', 'Check-out is by 11:00 am tomorrow.'],
    thanks: ['Thank you for staying', 'We hope you enjoyed your stay.'],
  };
  const events = reminderSchedule(stay).map((reminder) => {
    const [summary, description] = copy[reminder.kind];
    const start = localDateTime(reminder.date, reminder.time);
    return [
      'BEGIN:VEVENT',
      `UID:${reminder.id}.${stay.arrival}@gaestehaus-wild.com`,
      `DTSTART;TZID=Europe/Berlin:${start}`,
      'DURATION:PT15M',
      `SUMMARY:${escapeICS(summary)}`,
      `DESCRIPTION:${escapeICS(description)}`,
      'BEGIN:VALARM',
      'ACTION:DISPLAY',
      'TRIGGER:PT0M',
      `DESCRIPTION:${escapeICS(summary)}`,
      'END:VALARM',
      'END:VEVENT',
    ].join('\r\n');
  });
  return ['BEGIN:VCALENDAR', 'VERSION:2.0', 'PRODID:-//Gaestehaus Wild//Guest Stay//DE', 'CALSCALE:GREGORIAN', ...events, 'END:VCALENDAR', ''].join('\r\n');
}
