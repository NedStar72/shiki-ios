import AuthCore
import Combine
import Foundation
import UIKit

@Observable
public final class AuthViewModel {
  @ObservationIgnored
  private var subscriptions: [AnyCancellable] = []

  @ObservationIgnored
  private let authRepository: AuthRepository

  var isLoggedIn = false

  public init(authRepository: AuthRepository) {
    self.authRepository = authRepository
  }

  func setup() {
    authRepository
      .isLoggedIn
      .receive(on: DispatchQueue.main)
      .sink {
        self.isLoggedIn = $0
      }
      .store(in: &subscriptions)
  }

  func handleSignInPressed() {
    _ = authRepository
      .login()
  }

  func handleSignOutPressed() {
    _ = authRepository
      .logout()
  }
}
