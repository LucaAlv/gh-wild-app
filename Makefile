DEVELOPER_DIR := /Applications/Xcode.app/Contents/Developer
SIM := 55FF1755-3EA9-488B-86E4-65BB393F97A0
BUNDLE := com.gaestehauswild.app
APP := .build/Build/Products/Debug-iphonesimulator/GaestehausWild.app

.PHONY: generate build boot run clean shots

generate:
	DEVELOPER_DIR=$(DEVELOPER_DIR) xcodegen generate

build: generate
	DEVELOPER_DIR=$(DEVELOPER_DIR) xcodebuild -project GaestehausWild.xcodeproj -scheme GaestehausWild -configuration Debug -destination "platform=iOS Simulator,id=$(SIM)" -derivedDataPath .build build

boot:
	DEVELOPER_DIR=$(DEVELOPER_DIR) xcrun simctl boot "$(SIM)" 2>/dev/null || true
	DEVELOPER_DIR=$(DEVELOPER_DIR) xcrun simctl bootstatus "$(SIM)" -b

run: build boot
	DEVELOPER_DIR=$(DEVELOPER_DIR) xcrun simctl install "$(SIM)" "$(APP)"
	DEVELOPER_DIR=$(DEVELOPER_DIR) xcrun simctl launch "$(SIM)" "$(BUNDLE)"
	open -a Simulator

shots: build boot
	mkdir -p screenshots
	DEVELOPER_DIR=$(DEVELOPER_DIR) xcrun simctl install "$(SIM)" "$(APP)"
	DEVELOPER_DIR=$(DEVELOPER_DIR) xcrun simctl status_bar "$(SIM)" override --time "9:41" --batteryState charged --batteryLevel 100
	DEVELOPER_DIR=$(DEVELOPER_DIR) xcrun simctl launch "$(SIM)" "$(BUNDLE)"
	sleep 2
	DEVELOPER_DIR=$(DEVELOPER_DIR) xcrun simctl io "$(SIM)" screenshot screenshots/01-home.png

clean:
	DEVELOPER_DIR=$(DEVELOPER_DIR) xcodebuild -project GaestehausWild.xcodeproj -scheme GaestehausWild -derivedDataPath .build clean 2>/dev/null || true
