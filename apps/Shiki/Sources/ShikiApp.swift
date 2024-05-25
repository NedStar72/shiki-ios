import NeedleFoundation
import SwiftUI

@main
struct ShikiApp: App {
  let rootComponent: RootComponent

  init() {
    registerProviderFactories()
    rootComponent = RootComponent()
  }

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
