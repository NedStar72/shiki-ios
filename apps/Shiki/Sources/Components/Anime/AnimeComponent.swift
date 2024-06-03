import AnimeCore
import AnimeImplementation
import AnimeUI
import Foundation
import NeedleFoundation
import Network

protocol AnimeDependency: Dependency {
  var networkWithoutAuthorization: Network { get }
}

final class AnimeComponent: Component<AnimeDependency> {
  public var animeGateway: AnimeGateway {
    shared {
      AnimeGatewayImplementation(network: dependency.networkWithoutAuthorization)
    }
  }

  public var animeRepository: AnimeRepository {
    shared {
      AnimeRepositoryImplementation(animeGateway: animeGateway)
    }
  }

  public var animeListViewModel: AnimeListViewModel {
    AnimeListViewModel(animeRepository: animeRepository)
  }

  var animeList: AnimeList {
    AnimeList(viewModel: animeListViewModel)
  }
}
