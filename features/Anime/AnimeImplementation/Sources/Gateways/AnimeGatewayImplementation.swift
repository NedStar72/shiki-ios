import AnimeCore
import Network

public class AnimeGatewayImplementation: AnimeGateway {
  private let network: Network

  public init(network: Network) {
    self.network = network
  }

  public func fetchAnimeList() async throws -> [any AnimeCard] {
    let query = Query {
      BaseURL("https://shikimori.one") // TODO: вынести shikimori.one/api в network?
      Path {
        "api"
        "animes"
      }
      Param("limit", "50")
      Param("order", "ranked")
    }
    return try await network.request([AnimeCardImplementation].self, query, method: .get)
  }
}
