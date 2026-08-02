import SwiftUI

struct NearbyDetailScreen: View {
    @Environment(\.appLanguage) private var language
    let place: NearbyPlace

    var body: some View {
        PageScaffold(title: place.name) {
            if let image = place.image {
                PhotoView(name: image, aspectRatio: 16.0 / 10.0)
                    .clipShape(RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))
            } else {
                MiniMapCard(place: place)
            }

            VStack(alignment: .leading, spacing: Theme.Spacing.small) {
                Text(place.subtitle[language].uppercased())
                    .font(Theme.Typography.caption)
                    .tracking(1.4)
                    .foregroundStyle(Theme.ColorToken.brown)
                LeadParagraph(text: place.description)
                Text(Geo.formattedDistance(latitude: place.latitude, longitude: place.longitude, language: language))
                    .font(Theme.Typography.caption)
                    .foregroundStyle(Theme.ColorToken.graphite)
            }

            SectionHeader(title: .init(de: "So kommen Sie hin", en: "Getting there"))
            VStack(spacing: Theme.Spacing.medium) {
                ForEach(Array(place.travel.enumerated()), id: \.offset) { index, estimate in
                    TravelRow(estimate: estimate)
                    if index < place.travel.count - 1 {
                        Divider().overlay(Theme.ColorToken.brown.opacity(0.16))
                    }
                }
            }
            .padding(Theme.Spacing.large)
            .background(Theme.ColorToken.paper, in: RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))

            if place.openingHours != nil || place.priceHint != nil {
                VStack(alignment: .leading, spacing: Theme.Spacing.medium) {
                    if let hours = place.openingHours {
                        InfoRow(symbol: "clock", label: .init(de: "Öffnungszeiten", en: "Opening hours"), value: hours)
                    }
                    if let price = place.priceHint {
                        InfoRow(symbol: "eurosign", label: .init(de: "Preis", en: "Price"), value: price)
                    }
                }
                .padding(Theme.Spacing.large)
                .background(Theme.ColorToken.paper, in: RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))
            }

            if let note = place.familyNote { FamilyNoteCallout(text: note) }

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ActionButton(
                    title: .init(de: "Karten", en: "Maps"),
                    symbol: "map.fill",
                    url: ExternalActions.mapsURL(latitude: place.latitude, longitude: place.longitude, name: place.name[language])
                )
                if let website = place.website, let url = URL(string: website) {
                    ActionButton(title: .init(de: "Website", en: "Website"), symbol: "safari.fill", url: url)
                }
                if let phone = place.phone, let url = URL(string: "tel:\(phone)") {
                    ActionButton(title: .init(de: "Anrufen", en: "Call"), symbol: "phone.fill", url: url)
                }
            }
        }
    }
}
