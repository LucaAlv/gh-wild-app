import Foundation
import Testing

@Suite("App deep links")
struct DeepLinkTests {
    @Test("Guest shortcut opens instant access")
    func guestShortcut() {
        #expect(DeepLink.parse(URL(string: "gaestehauswild://gast")!) == .page(.guestNow))
    }

    @Test("Page and nearby links parse")
    func destinations() {
        #expect(DeepLink.parse(URL(string: "gaestehauswild://page/breakfast")!) == .page(.breakfast))
        #expect(DeepLink.parse(URL(string: "gaestehauswild://nearby/playmobil")!) == .nearby(placeID: "playmobil"))
    }

    @Test("Malformed and foreign links are rejected", arguments: [
        "https://gaestehauswild.de/gast",
        "gaestehauswild://unknown",
        "gaestehauswild://page/not-a-page",
        "gaestehauswild://nearby",
        "gaestehauswild://gast/extra",
        "gaestehauswild://gast?source=card"
    ])
    func rejects(value: String) {
        #expect(DeepLink.parse(URL(string: value)!) == nil)
    }

    @Test("Every page and a percent-encoded place ID round-trip")
    func roundTrip() {
        for page in Page.allCases {
            let link = DeepLink.page(page)
            #expect(link.url.flatMap(DeepLink.parse) == link)
        }
        for place in Content.nearbyPlaces {
            let link = DeepLink.nearby(placeID: place.id)
            #expect(link.url.flatMap(DeepLink.parse) == link)
        }
        let nearby = DeepLink.nearby(placeID: "café-test")
        #expect(nearby.url.flatMap(DeepLink.parse) == nearby)
    }
}
