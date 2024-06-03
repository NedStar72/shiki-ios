import AppAuth
import AuthCore
import Combine
import CombineUtils
import KeychainKit
import SwiftUtils

public class AuthRepositoryImplementation: AuthRepository {
  private let keychain: Keychain
  private let deepLinks: AnyPublisher<URL, Never>
  private let oauthRequest: OIDAuthorizationRequest
  private let authGateway: AuthGateway

  private var currentAuthorizationFlow: OIDExternalUserAgentSession?

  private var accessTokenSubject: CurrentValueSubject<String?, Never>

  public var isLoggedIn: AnyPublisher<Bool, Never> {
    accessTokenSubject
      // TODO: нельзя опираться на наличие токена для определения isLoggedIn
      .map { $0 == nil ? false : true }
      .eraseToAnyPublisher()
  }

  public init(keychain: Keychain,
              deepLinks: AnyPublisher<URL, Never>,
              oauthRequest: OIDAuthorizationRequest,
              authGateway: AuthGateway) {
    self.keychain = keychain
    self.deepLinks = deepLinks
    self.oauthRequest = oauthRequest
    self.authGateway = authGateway

    accessTokenSubject = .init(keychain.accessToken)
  }

  private func setTokens(accessToken: String?, refreshToken: String?) {
    keychain.accessToken = accessToken
    keychain.refreshToken = refreshToken

    accessTokenSubject.send(accessToken)
  }

  @MainActor private func oauth() async throws -> OIDAuthState {
    guard let rootViewController = UIApplication.shared.rootViewController else {
      throw AuthRepositoryError.noRootViewController
    }

    let oauthDeeplinkTask = Task { [unowned self] in
      let url: URL? = await deepLinks.values.first { url in
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true), components.host == "oauth" else {
          return false
        }
        return true
      }

      if let url,
         let currentAuthorizationFlow {
        currentAuthorizationFlow.resumeExternalUserAgentFlow(with: url)
        self.currentAuthorizationFlow = nil
      }
    }

    defer {
      oauthDeeplinkTask.cancel()
    }

    return try await withCheckedThrowingContinuation { continuation in
      self.currentAuthorizationFlow = OIDAuthState.authState(byPresenting: self.oauthRequest, presenting: rootViewController) { authState, error in
        if let authState {
          continuation.resume(with: .success(authState))
        } else if let error {
          continuation.resume(with: .failure(error))
        }
      }
    }
  }

  public func login() -> AnyPublisher<Void, any Error> {
    Future { [unowned self] in
      let authStatus = try await oauth()
      guard let accessToken = authStatus.lastTokenResponse?.accessToken,
            let refreshToken = authStatus.lastTokenResponse?.refreshToken
      else { return }
      setTokens(accessToken: accessToken, refreshToken: refreshToken)
    }
    .eraseToAnyPublisher()
  }

  public func logout() -> AnyPublisher<Void, any Error> {
    // TODO: переделать на Empty?
    Future { [unowned self] in
      setTokens(accessToken: nil, refreshToken: nil)
    }
    .eraseToAnyPublisher()
  }

  public func refreshTokens() -> AnyPublisher<Void, any Error> {
    // TODO: Future + unowned self + async-await = 💩?
    Future { [unowned self] in
      guard let refreshToken = keychain.refreshToken else {
        throw AuthRepositoryError.noRefreshToken
      }
      let (newAccessToken, newRefreshToken) = try await authGateway.refreshTokens(refreshToken)
      setTokens(accessToken: newAccessToken, refreshToken: newRefreshToken)
    }
    .eraseToAnyPublisher()
  }
}
