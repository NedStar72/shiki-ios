import Foundation

public enum AnimeGatewayError: Error {}

public protocol AnimeGateway {
  func fetchAnimeList() async throws -> [any AnimeCard]
}
