import SwiftUI

struct NearbyScreen: View {
    @State private var selected: PlaceCategory?

    private var places: [NearbyPlace] {
        Content.nearbyPlaces
            .filter { selected == nil || $0.categories.contains(selected!) }
            .sorted {
                Geo.distanceInKilometres(latitude: $0.latitude, longitude: $0.longitude)
                    < Geo.distanceInKilometres(latitude: $1.latitude, longitude: $1.longitude)
            }
    }

    var body: some View {
        PageScaffold(title: Page.nearby.title) {
            LeadParagraph(text: Content.nearbyIntro)
            CategoryChipRow(selection: $selected)
            LazyVStack(spacing: Theme.Spacing.large) {
                ForEach(places) { place in
                    NavigationLink(value: place) {
                        NearbyPlaceCard(place: place)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}
