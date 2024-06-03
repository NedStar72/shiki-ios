import Combine

public protocol AnimeRepository {
  func fetchAnimeList() -> AnyPublisher<[any AnimeCard], any Error>
}
