import AuthCore
import Foundation
import KeychainKit
import Network

public final class AccessTokenInterceptor: RequestInterceptor {
  let keychain: Keychain
  let authRepository: AuthRepository

  public init(keychain: Keychain, authRepository: AuthRepository) {
    self.keychain = keychain
    self.authRepository = authRepository
  }

  public func adapt(_ urlRequest: URLRequest) async throws -> URLRequest {
    var urlRequest = urlRequest
    if let accessToken = keychain.accessToken {
      urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
    }
    return urlRequest
  }

  public func retry(_: URLRequest, dueTo error: any Error, response: HTTPURLResponse?) async -> RetryResult {
    guard let response, response.statusCode == 401 else {
      /// The request did not fail due to a 401 Unauthorized response.
      /// Return the original error and don't retry the request.
      return .doNotRetryWithError(error)
    }
    do {
      _ = try await authRepository.refreshTokens().values.first { true }
      return .retry
    } catch {
      return .doNotRetryWithError(error)
    }
  }
}
