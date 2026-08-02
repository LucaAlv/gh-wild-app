import SwiftUI

struct ArrivalScreen: View {
    var body: some View {
        PageScaffold(title: Page.arrival.title) {
            LeadParagraph(text: Content.Arrival.intro)
            ForEach(Content.Arrival.routes) { route in
                TransitRouteCard(route: route)
            }
            ActionButtonRow(includeRoute: true)
        }
    }
}

private struct TransitRouteCard: View {
    @Environment(\.appLanguage) private var language
    let route: TransitRoute

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.large) {
            HStack(alignment: .top, spacing: Theme.Spacing.medium) {
                Image(systemName: route.symbol)
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(Theme.ColorToken.brown)
                    .frame(width: 32)
                VStack(alignment: .leading, spacing: 4) {
                    Text(route.destination[language])
                        .font(Theme.Typography.title2)
                    Text(route.durationSummary[language])
                        .font(Theme.Typography.caption)
                        .foregroundStyle(Theme.ColorToken.brown)
                }
            }

            VStack(alignment: .leading, spacing: Theme.Spacing.medium) {
                ForEach(Array(route.steps.enumerated()), id: \.offset) { index, step in
                    HStack(alignment: .top, spacing: Theme.Spacing.medium) {
                        Text("\(index + 1)")
                            .font(Theme.Typography.caption)
                            .foregroundStyle(Theme.ColorToken.paper)
                            .frame(width: 24, height: 24)
                            .background(Theme.ColorToken.brown, in: Circle())
                        Text(step[language])
                            .font(Theme.Typography.body)
                            .foregroundStyle(Theme.ColorToken.ink)
                    }
                }
            }
            if let tip = route.tip { FamilyNoteCallout(text: tip) }
        }
        .padding(Theme.Spacing.large)
        .background(Theme.ColorToken.paper.opacity(0.62), in: RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))
        .overlay { RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius).stroke(Theme.ColorToken.brown.opacity(0.18)) }
    }
}
