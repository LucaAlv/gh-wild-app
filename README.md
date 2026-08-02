# Gästehaus Wild for iOS

A bilingual, offline-first SwiftUI companion for guests of [Gästehaus Wild](https://www.gaestehaus-wild.com/) in Oberasbach.

The app is an offline-first companion before and during a stay. Guests can save trip dates locally, see timely check-in, Wi-Fi, breakfast and check-out information, opt into local reminders, and browse a curated bilingual area guide without an account or network connection. Calling, e-mail and directions remain one tap away; there is deliberately no booking or inquiry form.

## Requirements

- macOS with Xcode 26 or newer
- [XcodeGen](https://github.com/yonaskolb/XcodeGen) (`brew install xcodegen`)

## Run

```bash
make run
```

Run the pure-logic test suite with:

```bash
make test
```

DEBUG builds support launch arguments for quickly checking stay phases and compressed local notifications:

```bash
xcrun simctl launch booted com.gaestehauswild.app \
  -startPage myStay -debugStayArrivalOffset -1 -debugStayDepartureOffset 2

xcrun simctl launch booted com.gaestehauswild.app \
  -startPage myStay -debugCompressNotifications YES
```

The generated `GaestehausWild.xcodeproj` is intentionally ignored. `project.yml` is the source of truth.

See [CONTENT-EDITING.md](CONTENT-EDITING.md) for editing text and replacing photos.
