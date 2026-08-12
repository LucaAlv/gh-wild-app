import { describe, expect, it } from 'vitest';
import { distanceInKilometres, formattedDistance } from './geo';
import { wifiPayload } from './wifi';

describe('offline helpers', () => {
  it('calculates a plausible PLAYMOBIL FunPark distance', () => {
    const distance = distanceInKilometres(49.4307, 10.9410);
    expect(distance).toBeGreaterThan(2.5);
    expect(distance).toBeLessThan(3.5);
    expect(formattedDistance(49.4307, 10.9410, 'de')).toContain(',');
  });

  it('escapes reserved Wi-Fi QR characters', () => {
    expect(wifiPayload('A;B:C,D\\E"', 'p;:,')).toBe('WIFI:T:WPA;S:A\\;B\\:C\\,D\\\\E\\";P:p\\;\\:\\,;H:false;;');
  });
});
