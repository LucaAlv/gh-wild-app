import SwiftUI

struct RoomsScreen: View {
    @Environment(\.appLanguage) private var language

    var body: some View {
        PageScaffold(title: Page.rooms.title) {
            LeadParagraph(text: .init(
                de: "Ob Kurzurlaub, Familienbesuch oder Geschäftsreise – unsere Zimmer sind flexibel gestaltet, um Ihren Bedürfnissen gerecht zu werden.",
                en: "Whether you are here for a short break, a family visit or a business trip, our rooms are designed to suit your needs."
            ))

            SectionHeader(
                eyebrow: .init(de: "In jedem Zimmer", en: "In every room"),
                title: .init(de: "Ausstattung", en: "Amenities")
            )
            FeatureList(features: Content.roomAmenities)

            SectionHeader(
                eyebrow: .init(de: "Individuell & gemütlich", en: "Individual & cosy"),
                title: .init(de: "Zimmerkategorien", en: "Room categories")
            )

            LazyVStack(spacing: Theme.Spacing.large) {
                ForEach(Content.rooms) { room in
                    NavigationLink(value: room) {
                        RoomCard(room: room)
                    }
                    .buttonStyle(.plain)
                }
            }

            Text(language == .de
                 ? "Zusätzliche Kinder- oder Babybetten sind auf Anfrage gegen Aufpreis möglich. Bitte beachten Sie, dass sich die Preise während Messen oder Aktionszeiträumen ändern können."
                 : "Extra children’s beds or cots are available on request for a surcharge. Prices may vary during trade fairs or special periods.")
                .font(Theme.Typography.caption)
                .foregroundStyle(Theme.ColorToken.graphite)
                .lineSpacing(4)
        }
    }
}

struct RoomDetailScreen: View {
    @Environment(\.appLanguage) private var language
    let room: Room

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Theme.Spacing.xLarge) {
                ImageCarousel(images: room.images)

                VStack(alignment: .leading, spacing: Theme.Spacing.large) {
                    HStack(alignment: .firstTextBaseline) {
                        Text(room.name[language])
                            .font(Theme.Typography.display)
                        Spacer(minLength: 12)
                        PriceBadge(price: room.price)
                    }
                    Text(room.occupancy[language])
                        .font(Theme.Typography.bodyStrong)
                        .foregroundStyle(Theme.ColorToken.brown)
                    BodyText(text: room.description)

                    SectionHeader(title: .init(de: "Ausstattung", en: "Amenities"))
                    FeatureList(features: Content.roomAmenities)

                    SectionHeader(
                        eyebrow: .init(de: "Direkt bei uns", en: "Contact us directly"),
                        title: .init(de: "Zimmer anfragen", en: "Ask about this room")
                    )
                    ActionButtonRow()
                }
                .padding(.horizontal, Theme.Metric.gutter)
                .padding(.bottom, Theme.Spacing.section)
            }
        }
        .pageBackground()
        .navigationTitle(room.name[language])
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ImageCarousel: View {
    @State private var selection = 0
    let images: [String]

    var body: some View {
        VStack(spacing: 12) {
            TabView(selection: $selection) {
                ForEach(Array(images.enumerated()), id: \.offset) { index, image in
                    PhotoView(name: image, aspectRatio: nil)
                        .tag(index)
                }
            }
            .frame(height: 360)
            .tabViewStyle(.page(indexDisplayMode: .never))

            HStack(spacing: 7) {
                ForEach(images.indices, id: \.self) { index in
                    Circle()
                        .fill(index == selection ? Theme.ColorToken.brown : Theme.ColorToken.brown.opacity(0.25))
                        .frame(width: 7, height: 7)
                }
            }
            .accessibilityHidden(true)
        }
    }
}
