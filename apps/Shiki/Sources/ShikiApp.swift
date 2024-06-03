import AuthCore
import NavigationKit
import NeedleFoundation
import RootCore
import SwiftUI

enum FirstTabStep: Step {
  case animeList
}

enum SecondTabStep: Step {
  case profile
}

@main
struct ShikiApp: App {
  private let rootComponent: RootComponent
  private let animeComponent: AnimeComponent
  private let profileComponent: ProfileComponent

  @State var appViewModel: AppViewModel

  init() {
    registerProviderFactories()
    rootComponent = RootComponent()
    animeComponent = rootComponent.animeComponent
    profileComponent = rootComponent.profileComponent

    appViewModel = rootComponent.appViewModel
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
        Coordinator(initialStep: .profile) { (step: SecondTabStep) in
          switch step {
          case .profile:
            profileComponent.profile
          }
        }
        .stack()
        .tabItem {
          Label("Профиль", systemImage: "person.crop.circle.fill")
        }
      }
      .onOpenURL { incomingURL in
        appViewModel.handle(url: incomingURL)
      }
    }
  }
}
