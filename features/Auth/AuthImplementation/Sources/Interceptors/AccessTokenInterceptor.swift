import AuthCore
import Foundation
import KeychainKit
import Network

public final class AccessTokenInterceptor: RequestInterceptor {
  let keychain: Keychain

  public init(keychain: Keychain) {
    self.keychain = keychain
  }

  public func adapt(_ urlRequest: URLRequest) async throws -> URLRequest {
    var urlRequest = urlRequest
    if let accessToken = keychain.accessToken {
      urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
    }
    return urlRequest
  }
}
