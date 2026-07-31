import SwiftUI

private struct GallerySelection: Identifiable {
    let id: Int
}

struct GalleryScreen: View {
    @Environment(\.appLanguage) private var language
    @State private var selection: GallerySelection?

    private let columns = [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)]

    var body: some View {
        PageScaffold(title: Page.gallery.title) {
            Text(language == .de
                 ? "Ein Blick in unser Haus, unsere Zimmer und den Garten."
                 : "A glimpse inside our house, rooms and garden.")
                .font(Theme.Typography.body)
                .foregroundStyle(Theme.ColorToken.graphite)

            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(Array(Content.galleryImages.enumerated()), id: \.offset) { index, image in
                    Button {
                        selection = GallerySelection(id: index)
                    } label: {
                        PhotoView(name: image, aspectRatio: 1)
                            .frame(minHeight: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(language == .de ? "Foto \(index + 1) öffnen" : "Open photo \(index + 1)")
                }
            }
        }
        .fullScreenCover(item: $selection) { item in
            PhotoViewerScreen(images: Content.galleryImages, initialIndex: item.id)
        }
    }
}

struct PhotoViewerScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.appLanguage) private var language
    @State private var selection: Int
    let images: [String]

    init(images: [String], initialIndex: Int) {
        self.images = images
        _selection = State(initialValue: initialIndex)
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.black.ignoresSafeArea()

            TabView(selection: $selection) {
                ForEach(Array(images.enumerated()), id: \.offset) { index, image in
                    ZoomablePhoto(name: image)
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))

            Button { dismiss() } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(width: 44, height: 44)
                    .background(.black.opacity(0.5), in: Circle())
            }
            .padding(.top, 8)
            .padding(.trailing, 14)
            .accessibilityLabel(language == .de ? "Galerie schließen" : "Close gallery")
        }
        .statusBarHidden()
    }
}

private struct ZoomablePhoto: View {
    @State private var scale: CGFloat = 1
    @GestureState private var gestureScale: CGFloat = 1
    let name: String

    var body: some View {
        Image(name)
            .resizable()
            .scaledToFit()
            .scaleEffect(max(1, scale * gestureScale))
            .gesture(
                MagnificationGesture()
                    .updating($gestureScale) { value, state, _ in state = value }
                    .onEnded { value in scale = min(max(1, scale * value), 5) }
            )
            .onTapGesture(count: 2) {
                withAnimation(.spring(response: 0.3)) { scale = scale > 1 ? 1 : 2.5 }
            }
            .accessibilityHidden(true)
    }
}
