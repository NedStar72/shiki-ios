import AuthCore
import NeedleFoundation
import SwiftUI

@main
struct ShikiApp: App {
  private let rootComponent: RootComponent

  @State var authViewModel: AuthViewModel

  init() {
    registerProviderFactories()
    rootComponent = RootComponent()
    authViewModel = AuthViewModel(authRepository: rootComponent.authRepository)
  }

  var body: some Scene {
    WindowGroup {
      Auth(viewModel: authViewModel)
    }
  }
}
