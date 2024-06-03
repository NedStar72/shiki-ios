import AnimeCore
import Combine
import CombineUtils

public class AnimeRepositoryImplementation: AnimeRepository {
  private let animeGateway: any AnimeGateway

  public init(animeGateway: any AnimeGateway) {
    self.animeGateway = animeGateway
  }

  public func fetchAnimeList() -> AnyPublisher<[any AnimeCard], any Error> {
    Future { [unowned self] in
      try await animeGateway.fetchAnimeList()
    }.eraseToAnyPublisher()
  }
}
