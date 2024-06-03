import Foundation

public protocol AuthGateway {
  func refreshTokens(_ refreshToken: String) async throws -> (accessToken: String, refreshToken: String)
}
