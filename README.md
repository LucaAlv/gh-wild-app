# Gästehaus Wild for iOS

A bilingual, offline-first SwiftUI companion for guests of [Gästehaus Wild](https://www.gaestehaus-wild.com/) in Oberasbach.

The first version mirrors the public information on the website without a booking or inquiry form. Guests can call, e-mail, open directions, and browse all content and photos without a network connection.

## Requirements

- macOS with Xcode 26 or newer
- [XcodeGen](https://github.com/yonaskolb/XcodeGen) (`brew install xcodegen`)

## Run

```bash
make run
```

The generated `GaestehausWild.xcodeproj` is intentionally ignored. `project.yml` is the source of truth.

See [CONTENT-EDITING.md](CONTENT-EDITING.md) for editing text and replacing photos.
