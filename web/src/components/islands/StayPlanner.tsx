import { useEffect, useMemo, useState } from 'react';
import { createCalendar } from '../../lib/ics';
import { addDays, berlinToday, normalizeStay, phaseFor, readStay, type Stay } from '../../lib/stay';

type Room = { id: string; name: { de: string; en: string } };

function dateLabel(date: string, locale: 'de' | 'en') {
  return new Intl.DateTimeFormat(locale === 'de' ? 'de-DE' : 'en-GB', {
    weekday: 'short', day: 'numeric', month: 'long', year: 'numeric', timeZone: 'Europe/Berlin',
  }).format(new Date(`${date}T12:00:00Z`));
}

export default function StayPlanner({ rooms, locale }: { rooms: Room[]; locale: 'de' | 'en' }) {
  const today = berlinToday();
  const [stay, setStay] = useState<Stay | null>(null);
  const [editing, setEditing] = useState(true);
  const [arrival, setArrival] = useState(today);
  const [departure, setDeparture] = useState(addDays(today, 1));
  const [roomId, setRoomId] = useState('');

  useEffect(() => {
    const parameters = new URLSearchParams(window.location.search);
    const fromUrl = parameters.get('arrival') && parameters.get('departure') ? {
      arrival: parameters.get('arrival')!, departure: parameters.get('departure')!, roomId: parameters.get('room') || undefined,
    } : null;
    let restored: Stay | null = null;
    try { restored = fromUrl ? normalizeStay(fromUrl) : readStay(window.localStorage); } catch { restored = readStay(window.localStorage); }
    if (restored) {
      setStay(restored); setArrival(restored.arrival); setDeparture(restored.departure); setRoomId(restored.roomId ?? ''); setEditing(false);
    }
  }, []);

  const phase = useMemo(() => phaseFor(stay), [stay]);
  const phaseText = (() => {
    if (phase.kind === 'upcoming') return locale === 'de' ? `Noch ${phase.daysUntilArrival === 1 ? 'ein Tag' : `${phase.daysUntilArrival} Tage`} bis zu Ihrem Aufenthalt` : `${phase.daysUntilArrival === 1 ? 'One day' : `${phase.daysUntilArrival} days`} until your stay`;
    if (phase.kind === 'arrivalDay') return locale === 'de' ? 'Heute ist Ihre Anreise' : 'You arrive today';
    if (phase.kind === 'inHouse') return locale === 'de' ? `Noch ${phase.nightsRemaining === 1 ? 'eine Nacht' : `${phase.nightsRemaining} Nächte`} bei uns` : `${phase.nightsRemaining === 1 ? 'One night' : `${phase.nightsRemaining} nights`} remaining`;
    if (phase.kind === 'departureDay') return locale === 'de' ? 'Heute ist Ihre Abreise' : 'You depart today';
    if (phase.kind === 'past') return locale === 'de' ? 'Schön, dass Sie bei uns waren' : 'Thank you for staying with us';
    return '';
  })();

  function save() {
    const next = normalizeStay({ arrival, departure, roomId: roomId || undefined });
    localStorage.setItem('gaestehaus-wild.stay', JSON.stringify(next));
    const parameters = new URLSearchParams({ arrival: next.arrival, departure: next.departure });
    if (next.roomId) parameters.set('room', next.roomId);
    history.replaceState(null, '', `${location.pathname}?${parameters}`);
    setStay(next); setDeparture(next.departure); setEditing(false);
  }

  function downloadCalendar() {
    if (!stay) return;
    const blob = new Blob([createCalendar(stay, locale)], { type: 'text/calendar;charset=utf-8' });
    const url = URL.createObjectURL(blob);
    const anchor = document.createElement('a');
    anchor.href = url; anchor.download = 'gaestehaus-wild-erinnerungen.ics'; anchor.click();
    URL.revokeObjectURL(url);
  }

  if (editing) return <div className="paper-panel">
    <form className="form-grid" onSubmit={(event) => { event.preventDefault(); save(); }}>
      <div className="field"><label htmlFor="arrival">{locale === 'de' ? 'Anreise' : 'Arrival'}</label><input id="arrival" type="date" min={today} required value={arrival} onChange={(event) => { setArrival(event.target.value); if (departure <= event.target.value) setDeparture(addDays(event.target.value, 1)); }} /></div>
      <div className="field"><label htmlFor="departure">{locale === 'de' ? 'Abreise' : 'Departure'}</label><input id="departure" type="date" min={addDays(arrival, 1)} required value={departure} onChange={(event) => setDeparture(event.target.value)} /></div>
      <div className="field full"><label htmlFor="stay-room">{locale === 'de' ? 'Zimmer (optional)' : 'Room (optional)'}</label><select id="stay-room" value={roomId} onChange={(event) => setRoomId(event.target.value)}><option value="">{locale === 'de' ? 'Noch nicht auswählen' : 'Not selected'}</option>{rooms.map((room) => <option value={room.id} key={room.id}>{room.name[locale]}</option>)}</select></div>
      <div className="field full"><button className="button" type="submit">{locale === 'de' ? 'Aufenthalt speichern' : 'Save stay'}</button></div>
    </form>
  </div>;

  return <div className="stay-layout">
    <div className="paper-panel stay-summary">
      <p className="eyebrow">{locale === 'de' ? 'Ihr Aufenthalt' : 'Your stay'}</p>
      <h3>{phaseText}</h3>
      <div className="stay-dates"><div className="date-block"><span>{locale === 'de' ? 'Anreise' : 'Arrival'}</span><strong>{dateLabel(stay!.arrival, locale)}</strong><small>{locale === 'de' ? 'Check-in ab 15:00' : 'Check-in from 3:00 pm'}</small></div><span className="date-arrow">→</span><div className="date-block"><span>{locale === 'de' ? 'Abreise' : 'Departure'}</span><strong>{dateLabel(stay!.departure, locale)}</strong><small>{locale === 'de' ? 'Check-out bis 11:00' : 'Check-out by 11:00 am'}</small></div></div>
      {stay?.roomId && <p>{locale === 'de' ? 'Zimmer:' : 'Room:'} <strong>{rooms.find((room) => room.id === stay.roomId)?.name[locale]}</strong></p>}
      <div className="hero-actions"><button className="button secondary compact" type="button" onClick={() => setEditing(true)}>{locale === 'de' ? 'Bearbeiten' : 'Edit'}</button><button className="button secondary compact" type="button" onClick={() => { localStorage.removeItem('gaestehaus-wild.stay'); history.replaceState(null, '', location.pathname); setStay(null); setEditing(true); }}>{locale === 'de' ? 'Löschen' : 'Delete'}</button></div>
    </div>
    <div className="paper-panel">
      <p className="eyebrow">{locale === 'de' ? 'Erinnerungen' : 'Reminders'}</p>
      <h3>{locale === 'de' ? 'Alles zur richtigen Zeit' : 'Everything at the right time'}</h3>
      <p>{locale === 'de' ? 'Laden Sie Check-in, Frühstück, Check-out und eine kleine Abschiedsnachricht als Kalendertermine herunter. Die Datei wird hier im Browser erstellt; Ihre Daten werden nicht übertragen.' : 'Download check-in, breakfast, check-out and a small farewell as calendar events. The file is created here in your browser; your dates are not transmitted.'}</p>
      <button className="button" type="button" onClick={downloadCalendar}>{locale === 'de' ? 'Erinnerungen in den Kalender' : 'Add reminders to calendar'}</button>
    </div>
  </div>;
}
