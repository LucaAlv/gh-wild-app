import SwiftUI
import MapKit

struct BodyText: View {
    @Environment(\.appLanguage) private var language
    let text: LocalizedText

    var body: some View {
        Text(text[language])
            .font(Theme.Typography.body)
            .foregroundStyle(Theme.ColorToken.graphite)
            .lineSpacing(6)
            .fixedSize(horizontal: false, vertical: true)
    }
}

struct LeadParagraph: View {
    @Environment(\.appLanguage) private var language
    let text: LocalizedText

    var body: some View {
        Text(text[language])
            .font(.system(.title3, design: .serif, weight: .regular))
            .foregroundStyle(Theme.ColorToken.ink)
            .lineSpacing(7)
            .fixedSize(horizontal: false, vertical: true)
    }
}

struct SectionHeader: View {
    @Environment(\.appLanguage) private var language
    let eyebrow: LocalizedText?
    let title: LocalizedText

    init(eyebrow: LocalizedText? = nil, title: LocalizedText) {
        self.eyebrow = eyebrow
        self.title = title
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.small) {
            if let eyebrow {
                Text(eyebrow[language].uppercased())
                    .font(Theme.Typography.caption)
                    .tracking(2.1)
                    .foregroundStyle(Theme.ColorToken.brown)
            }
            Text(title[language])
                .font(Theme.Typography.title)
                .foregroundStyle(Theme.ColorToken.ink)
            Rectangle()
                .fill(Theme.ColorToken.brown.opacity(0.28))
                .frame(height: 1)
        }
        .accessibilityElement(children: .combine)
    }
}

struct PageScaffold<ContentView: View>: View {
    @Environment(\.appLanguage) private var language
    let title: LocalizedText
    @ViewBuilder let content: ContentView

    init(title: LocalizedText, @ViewBuilder content: () -> ContentView) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Theme.Spacing.xLarge) {
                Text(title[language])
                    .font(Theme.Typography.display)
                    .foregroundStyle(Theme.ColorToken.ink)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
                    .padding(.top, Theme.Spacing.large)
                content
            }
            .padding(.horizontal, Theme.Metric.gutter)
            .padding(.bottom, Theme.Spacing.section)
            .frame(maxWidth: 720, alignment: .leading)
            .frame(maxWidth: .infinity)
        }
        .pageBackground()
        .navigationTitle(title[language])
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PhotoView: View {
    let name: String
    var aspectRatio: CGFloat? = 4.0 / 3.0
    var contentMode: ContentMode = .fill

    var body: some View {
        Image(name)
            .resizable()
            .aspectRatio(aspectRatio, contentMode: contentMode)
            .frame(maxWidth: .infinity)
            .background(Theme.ColorToken.paper)
            .clipped()
            .accessibilityHidden(true)
    }
}

struct HeroHeader: View {
    @Environment(\.appLanguage) private var language
    let image: String
    let eyebrow: LocalizedText
    let title: LocalizedText

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottomLeading) {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: proxy.size.width, height: Theme.Metric.heroHeight)
                    .clipped()
                    .overlay {
                        LinearGradient(
                            colors: [.clear, .black.opacity(0.72)],
                            startPoint: .center,
                            endPoint: .bottom
                        )
                    }
                    .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: Theme.Spacing.small) {
                    Image("wild-wappen")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 54, height: 70)
                        .accessibilityHidden(true)
                    Text(eyebrow[language].uppercased())
                        .font(Theme.Typography.caption)
                        .tracking(1.8)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                    Text(title[language])
                        .font(.system(size: 44, weight: .semibold, design: .serif))
                        .lineLimit(2)
                        .minimumScaleFactor(0.65)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .foregroundStyle(.white)
                .frame(width: proxy.size.width - (Theme.Metric.gutter * 2), alignment: .leading)
                .padding(Theme.Metric.gutter)
                .padding(.bottom, Theme.Spacing.large)
            }
        }
        .frame(height: Theme.Metric.heroHeight)
        .accessibilityElement(children: .combine)
    }
}

struct PriceBadge: View {
    @Environment(\.appLanguage) private var language
    let price: Int

    var body: some View {
        Text(language == .de ? "ab \(price) €" : "from €\(price)")
            .font(Theme.Typography.button)
            .foregroundStyle(Theme.ColorToken.paper)
            .padding(.horizontal, 13)
            .padding(.vertical, 8)
            .background(Theme.ColorToken.brown, in: Capsule())
    }
}

struct FeatureList: View {
    @Environment(\.appLanguage) private var language
    let features: [Feature]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(features) { feature in
                HStack(alignment: .firstTextBaseline, spacing: Theme.Spacing.medium) {
                    Image(systemName: feature.symbol)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Theme.ColorToken.brown)
                        .frame(width: 24)
                    Text(feature.title[language])
                        .font(Theme.Typography.body)
                        .foregroundStyle(Theme.ColorToken.ink)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.vertical, 12)
                if feature.id != features.last?.id {
                    Divider().overlay(Theme.ColorToken.brown.opacity(0.16))
                }
            }
        }
    }
}

struct ActionButton: View {
    @Environment(\.appLanguage) private var language
    let title: LocalizedText
    let symbol: String
    let url: URL

    var body: some View {
        Link(destination: url) {
            VStack(spacing: 8) {
                Image(systemName: symbol)
                    .font(.title3.weight(.semibold))
                Text(title[language])
                    .font(Theme.Typography.button)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity)
            .frame(minHeight: 76)
            .foregroundStyle(Theme.ColorToken.ink)
            .background(Theme.ColorToken.paper, in: RoundedRectangle(cornerRadius: 14))
            .overlay {
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Theme.ColorToken.brown.opacity(0.24), lineWidth: 1)
            }
        }
        .buttonStyle(.plain)
    }
}

struct ActionButtonRow: View {
    var includeRoute = false
    var includeInstagram = false

    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            ActionButton(title: .init(de: "Anrufen", en: "Call"), symbol: "phone.fill", url: ExternalActions.phone)
            ActionButton(title: .init(de: "E-Mail", en: "E-mail"), symbol: "envelope.fill", url: ExternalActions.email)
            if includeRoute {
                ActionButton(title: .init(de: "Route", en: "Directions"), symbol: "arrow.triangle.turn.up.right.diamond.fill", url: ExternalActions.mapsURL())
            }
            if includeInstagram {
                ActionButton(title: .init(de: "Instagram", en: "Instagram"), symbol: "camera.fill", url: ExternalActions.instagram)
            }
        }
    }
}

struct RoomCard: View {
    @Environment(\.appLanguage) private var language
    let room: Room

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            PhotoView(name: room.images[0], aspectRatio: 16.0 / 10.0)
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .firstTextBaseline) {
                    Text(room.name[language])
                        .font(Theme.Typography.title2)
                    Spacer(minLength: 10)
                    PriceBadge(price: room.price)
                }
                Text(room.occupancy[language])
                    .font(Theme.Typography.body)
                    .foregroundStyle(Theme.ColorToken.graphite)
                HStack {
                    Text(language == .de ? "Zimmer ansehen" : "View room")
                        .font(Theme.Typography.button)
                    Spacer()
                    Image(systemName: "arrow.right")
                }
                .foregroundStyle(Theme.ColorToken.brown)
                .padding(.top, 4)
            }
            .padding(Theme.Spacing.medium)
        }
        .background(Theme.ColorToken.paper, in: RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))
        .clipShape(RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))
        .shadow(color: .black.opacity(0.06), radius: 12, y: 5)
    }
}

struct TeaserCard: View {
    @Environment(\.appLanguage) private var language
    let page: Page
    let image: String
    let text: LocalizedText

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            PhotoView(name: image, aspectRatio: 3.0 / 2.0)
            VStack(alignment: .leading, spacing: Theme.Spacing.small) {
                Text(page.title[language])
                    .font(Theme.Typography.title2)
                    .foregroundStyle(Theme.ColorToken.ink)
                Text(text[language])
                    .font(Theme.Typography.body)
                    .foregroundStyle(Theme.ColorToken.graphite)
                    .lineLimit(3)
                HStack {
                    Text(language == .de ? "Mehr erfahren" : "Discover more")
                        .font(Theme.Typography.button)
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

struct MapSnapshotCard: View {
    private let coordinate = Geo.guesthouse

    var body: some View {
        Map(initialPosition: .region(MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.018, longitudeDelta: 0.018)
        )), interactionModes: []) {
            Marker("Gästehaus Wild", coordinate: coordinate)
                .tint(Theme.ColorToken.brown)
        }
        .frame(height: 260)
        .clipShape(RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))
        .overlay {
            RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius)
                .stroke(Theme.ColorToken.brown.opacity(0.22))
        }
        .accessibilityLabel("Gästehaus Wild, Jahnstraße 77, Oberasbach")
    }
}

struct InfoRow: View {
    @Environment(\.appLanguage) private var language
    let symbol: String
    let label: LocalizedText
    let value: LocalizedText

    var body: some View {
        HStack(alignment: .top, spacing: Theme.Spacing.medium) {
            Image(systemName: symbol)
                .foregroundStyle(Theme.ColorToken.brown)
                .frame(width: 24)
            VStack(alignment: .leading, spacing: 3) {
                Text(label[language].uppercased())
                    .font(Theme.Typography.caption)
                    .tracking(1.3)
                    .foregroundStyle(Theme.ColorToken.brown)
                Text(value[language])
                    .font(Theme.Typography.bodyStrong)
                    .foregroundStyle(Theme.ColorToken.ink)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
