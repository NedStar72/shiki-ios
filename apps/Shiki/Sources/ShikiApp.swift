import AuthCore
import NavigationKit
import NeedleFoundation
import RootCore
import SwiftUI

enum FirstTabStep: Step {
  case animeList
}

@main
struct ShikiApp: App {
  private let rootComponent: RootComponent
  private let animeComponent: AnimeComponent

  @State var appViewModel: AppViewModel
  @State var authViewModel: AuthViewModel

  init() {
    registerProviderFactories()
    rootComponent = RootComponent()
    animeComponent = rootComponent.animeComponent

    appViewModel = rootComponent.appViewModel
    authViewModel = AuthViewModel(authRepository: rootComponent.authRepository)
  }

  var body: some Scene {
    WindowGroup {
      TabView {
        Coordinator(initialStep: .animeList) { (step: FirstTabStep) in
          switch step {
          case .animeList:
            animeComponent.animeList
          }
        }
        .stack()
        .tabItem {
          Label("Поиск", systemImage: "magnifyingglass")
        }
        Auth(viewModel: authViewModel).tabItem {
          Label("Профиль", systemImage: "person.crop.circle.fill")
        }
      }
      .onOpenURL { incomingURL in
        appViewModel.handle(url: incomingURL)
      }
    }
  }
}
