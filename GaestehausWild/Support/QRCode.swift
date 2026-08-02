import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

enum WiFiQR {
    private static let context = CIContext(options: [.useSoftwareRenderer: false])

    static func payload(ssid: String, password: String) -> String {
        "WIFI:T:WPA;S:\(escape(ssid));P:\(escape(password));H:false;;"
    }

    static func image(ssid: String, password: String) -> CGImage? {
        let filter = CIFilter.qrCodeGenerator()
        filter.message = Data(payload(ssid: ssid, password: password).utf8)
        filter.correctionLevel = "M"
        guard let output = filter.outputImage?.transformed(by: .init(scaleX: 12, y: 12)) else { return nil }
        return context.createCGImage(output, from: output.extent)
    }

    private static func escape(_ value: String) -> String {
        value.reduce(into: "") { result, character in
            if "\\;,:\"".contains(character) { result.append("\\") }
            result.append(character)
        }
    }
}
