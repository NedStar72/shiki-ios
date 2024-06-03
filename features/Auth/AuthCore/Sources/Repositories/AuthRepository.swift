import Combine

public enum AuthRepositoryError: Error {
  case noRootViewController
  case noRefreshToken
}

public protocol AuthRepository {
  var isLoggedIn: AnyPublisher<Bool, Never> { get }

  // TODO: I would like to remove any error, but async/await does not produce. Waiting for Swift 6
  func login() -> AnyPublisher<Void, any Error>
  func logout() -> AnyPublisher<Void, any Error>
  func refreshTokens() -> AnyPublisher<Void, any Error>
}
