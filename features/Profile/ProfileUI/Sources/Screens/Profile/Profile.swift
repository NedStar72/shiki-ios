import SwiftUI
import SwiftUtils

public struct Profile: View {
  @ObservedObject var viewModel: ProfileViewModel

  public init(viewModel: ProfileViewModel) {
    self.viewModel = viewModel
  }

  public var body: some View {
    VStack {
      if let profile = viewModel.state.profile {
        Text(profile.nickname)
        Button("Выйти") {
          viewModel.action.send(.logout)
        }
      } else {
        Text("Вы не авторизованы")
        Button("Войти") {
          viewModel.action.send(.login)
        }
      }
    }
    .onMount {
      viewModel.action.send(.initial)
    }
  }
}
