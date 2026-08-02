import SwiftUI
import MapKit

struct CategoryChipRow: View {
    @Environment(\.appLanguage) private var language
    @Binding var selection: PlaceCategory?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Theme.Spacing.small) {
                chip(title: language == .de ? "Alle" : "All", symbol: "square.grid.2x2", category: nil)
                ForEach(PlaceCategory.allCases) { category in
                    chip(title: category.title[language], symbol: category.symbol, category: category)
                }
            }
            .padding(.vertical, 2)
        }
        .contentMargins(.horizontal, 0, for: .scrollContent)
    }

    private func chip(title: String, symbol: String, category: PlaceCategory?) -> some View {
        let isSelected = selection == category
        return Button {
            withAnimation(.easeInOut(duration: 0.18)) { selection = category }
        } label: {
            Label(title, systemImage: symbol)
                .font(Theme.Typography.button)
                .foregroundStyle(isSelected ? Theme.ColorToken.paper : Theme.ColorToken.brown)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(isSelected ? Theme.ColorToken.brown : Theme.ColorToken.paper, in: Capsule())
                .overlay { Capsule().stroke(Theme.ColorToken.brown.opacity(0.25)) }
        }
        .buttonStyle(.plain)
    }
}

struct NearbyPlaceCard: View {
    @Environment(\.appLanguage) private var language
    let place: NearbyPlace

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let image = place.image {
                PhotoView(name: image, aspectRatio: 16.0 / 9.0)
            } else {
                ZStack {
                    Theme.ColorToken.brown.opacity(0.1)
                    Image(systemName: place.categories.first?.symbol ?? "mappin")
                        .font(.system(size: 42, weight: .light))
                        .foregroundStyle(Theme.ColorToken.brown)
                }
                .frame(height: 150)
                .accessibilityHidden(true)
            }

            VStack(alignment: .leading, spacing: Theme.Spacing.small) {
                Text(place.subtitle[language].uppercased())
                    .font(Theme.Typography.caption)
                    .tracking(1.4)
                    .foregroundStyle(Theme.ColorToken.brown)
                Text(place.name[language])
                    .font(Theme.Typography.title2)
                    .foregroundStyle(Theme.ColorToken.ink)
                HStack(spacing: Theme.Spacing.medium) {
                    if let travel = place.travel.first {
                        Label("\(travel.minutes) min", systemImage: travel.mode.symbol)
                    }
                    Label(
                        Geo.formattedDistance(latitude: place.latitude, longitude: place.longitude, language: language),
                        systemImage: "point.topleft.down.to.point.bottomright.curvepath"
                    )
                }
                .font(Theme.Typography.caption)
                .foregroundStyle(Theme.ColorToken.graphite)
                .lineLimit(1)
                .minimumScaleFactor(0.75)

                HStack {
                    Text(language == .de ? "Details ansehen" : "View details")
                        .font(Theme.Typography.button)
                    Spacer()
                    Image(systemName: "arrow.right")
                }
                .foregroundStyle(Theme.ColorToken.brown)
                .padding(.top, Theme.Spacing.xSmall)
            }
            .padding(Theme.Spacing.large)
        }
        .background(Theme.ColorToken.paper)
        .clipShape(RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))
        .shadow(color: .black.opacity(0.06), radius: 12, y: 5)
    }
}

struct TravelRow: View {
    @Environment(\.appLanguage) private var language
    let estimate: TravelEstimate

    var body: some View {
        HStack(alignment: .top, spacing: Theme.Spacing.medium) {
            Image(systemName: estimate.mode.symbol)
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(Theme.ColorToken.brown)
                .frame(width: 26)
            VStack(alignment: .leading, spacing: 4) {
                Text("\(estimate.mode.title[language]) · \(estimate.minutes) min")
                    .font(Theme.Typography.bodyStrong)
                if let note = estimate.note {
                    Text(note[language])
                        .font(Theme.Typography.body)
                        .foregroundStyle(Theme.ColorToken.graphite)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct FamilyNoteCallout: View {
    @Environment(\.appLanguage) private var language
    let text: LocalizedText

    var body: some View {
        HStack(alignment: .top, spacing: Theme.Spacing.medium) {
            Image("wild-wappen")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 32)
                .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: Theme.Spacing.xSmall) {
                Text(language == .de ? "Tipp der Familie Wild" : "The Wild family’s tip")
                    .font(Theme.Typography.caption)
                    .tracking(1.1)
                    .textCase(.uppercase)
                    .foregroundStyle(Theme.ColorToken.brown)
                Text(text[language])
                    .font(Theme.Typography.body)
                    .foregroundStyle(Theme.ColorToken.ink)
                    .lineSpacing(4)
            }
        }
        .padding(Theme.Spacing.large)
        .background(Theme.ColorToken.paper, in: RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))
        .overlay(alignment: .leading) {
            Rectangle().fill(Theme.ColorToken.brown).frame(width: 3).padding(.vertical, 12)
        }
    }
}

struct MiniMapCard: View {
    @Environment(\.appLanguage) private var language
    let place: NearbyPlace

    var body: some View {
        let coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        Map(initialPosition: .region(.init(
            center: coordinate,
            span: .init(latitudeDelta: 0.018, longitudeDelta: 0.018)
        )), interactionModes: []) {
            Marker(place.name[language], coordinate: coordinate)
                .tint(Theme.ColorToken.brown)
        }
        .frame(height: 220)
        .clipShape(RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))
        .overlay { RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius).stroke(Theme.ColorToken.brown.opacity(0.22)) }
        .accessibilityLabel(place.name[language])
    }
}
