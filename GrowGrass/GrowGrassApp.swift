

import SwiftUI

@main
struct GrowGrassApp: App {
    var body: some Scene {
        MenuBarExtra("Sample", systemImage: "star.fill") {
            MenuView()
        }
        .menuBarExtraStyle(.window)
    }
}
