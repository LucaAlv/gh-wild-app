import Foundation
import Testing

@Suite("Offline helpers")
struct GeoAndWiFiTests {
    @Test("PLAYMOBIL FunPark is a plausible nearby distance")
    func knownDistance() {
        let distance = Geo.distanceInKilometres(latitude: 49.4307, longitude: 10.9410)
        #expect(distance > 2.5 && distance < 3.5)
        #expect(Geo.formattedDistance(latitude: 49.4307, longitude: 10.9410, language: .de).contains(","))
    }

    @Test("Wi-Fi QR payload escapes reserved characters")
    func qrEscaping() {
        #expect(WiFiQR.payload(ssid: "A;B:C,D\\E\"", password: "p;:,") == "WIFI:T:WPA;S:A\\;B\\:C\\,D\\\\E\\\";P:p\\;\\:\\,;H:false;;")
    }

    @Test("Generic QR codes render")
    func genericQRCode() {
        #expect(QRCode.image(from: "gaestehauswild://gast") != nil)
    }
}
