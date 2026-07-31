import SwiftUI

enum Theme {
    enum ColorToken {
        static let cream = Color("Cream")
        static let paper = Color("Paper")
        static let ink = Color("Ink")
        static let brown = Color("Brown")
        static let graphite = Color("Graphite")
        static let ash = Color("Ash")
    }

    enum Typography {
        static let display = Font.system(.largeTitle, design: .serif, weight: .semibold)
        static let title = Font.system(.title, design: .serif, weight: .semibold)
        static let title2 = Font.system(.title2, design: .serif, weight: .semibold)
        static let body = Font.custom("Avenir-Light", size: 17, relativeTo: .body)
        static let bodyStrong = Font.custom("Avenir-Medium", size: 17, relativeTo: .body)
        static let caption = Font.custom("Avenir-Medium", size: 12, relativeTo: .caption)
        static let button = Font.custom("Avenir-Heavy", size: 15, relativeTo: .body)
    }

    enum Spacing {
        static let xSmall: CGFloat = 6
        static let small: CGFloat = 10
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
        static let xLarge: CGFloat = 36
        static let section: CGFloat = 52
    }

    enum Metric {
        static let gutter: CGFloat = 22
        static let cornerRadius: CGFloat = 18
        static let heroHeight: CGFloat = 430
    }
}

extension View {
    func pageBackground() -> some View {
        background(Theme.ColorToken.cream.ignoresSafeArea())
            .foregroundStyle(Theme.ColorToken.ink)
    }
}
