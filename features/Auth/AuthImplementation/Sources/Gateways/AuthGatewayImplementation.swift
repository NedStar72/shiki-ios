import AuthCore
import Network

private struct RefreshTokensResponse: Codable {
  let accessToken: String
  let refreshToken: String

  enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
    case refreshToken = "refresh_token"
  }
}

public class AuthGatewayImplementation: AuthGateway {
  private let clientID: String
  private let clientSecret: String
  private let network: Network

  public init(clientID: String, clientSecret: String, network: Network) {
    self.clientID = clientID
    self.clientSecret = clientSecret
    self.network = network
  }

  public func refreshTokens(_ refreshToken: String) async throws -> (accessToken: String, refreshToken: String) {
    let query = Query {
      BaseURL("https://shikimori.one")
      Path {
        "oauth"
        "token"
      }
    }
    let response = try await network.request(
      RefreshTokensResponse.self,
      query,
      method: .post,
      parameters: [
        "grant_type": "refresh_token",
        "client_id": clientID,
        "client_secret": clientSecret,
        "refresh_token": refreshToken,
      ]
    )
    return (response.accessToken, response.refreshToken)
  }
}
