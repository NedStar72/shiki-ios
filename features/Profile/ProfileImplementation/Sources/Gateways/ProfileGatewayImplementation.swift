import Network
import ProfileCore

public class ProfileGatewayImplementation: ProfileGateway {
  private let network: Network

  public init(network: Network) {
    self.network = network
  }

  public func fetchProfile() async throws -> Profile {
    let query = Query {
      BaseURL("https://shikimori.one")
      Path {
        "api"
        "users"
        "whoami"
      }
    }
    return try await network.request(Profile.self, query, method: .get)
  }
}
