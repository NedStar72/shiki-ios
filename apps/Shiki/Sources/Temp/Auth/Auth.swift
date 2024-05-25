import SwiftUI
import SwiftUtils

public struct Auth: View {
  var viewModel: AuthViewModel

  public init(viewModel: AuthViewModel) {
    self.viewModel = viewModel
  }

  public var body: some View {
    VStack {
      if viewModel.isLoggedIn {
        Text("Profile")
        Button(action: viewModel.handleSignOutPressed) {
          Text("Sign Out")
        }
      } else {
        Text("You are not authrized")
        Button(action: viewModel.handleSignInPressed) {
          Text("Sign In")
        }
      }
    }.onMount(viewModel.setup)
  }
}
