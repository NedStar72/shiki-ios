import AnimeCore
import CasePaths
import Combine
import CombineUtils
import StateKit

public class AnimeListViewModel: Store {
  private var animeRepository: AnimeRepository

  public struct State {
    var search = ""
    var isFetching = false
    var isError = false
    var animes: [any AnimeCard] = []
  }

  public let initialState: State = .init()

  public var text: String {
    get {
      state.search
    }
    set {
      action.send(.updateSearch(newValue))
    }
  }

  public init(animeRepository: AnimeRepository) {
    self.animeRepository = animeRepository
  }

  @CasePathable
  public enum Action: Equatable {
    case updateSearch(String)
    case fetchAnimeList
  }

  public enum Mutation {
    case updateSearch(String)
    case fetchAnimeList
    case fetchAnimeListSuccess([any AnimeCard])
    case fetchAnimeListError(Error)
  }

  public func transform(action: AnyPublisher<Action, Never>) -> AnyPublisher<Action, Never> {
    let actionWithoutUpdateSearch = action
      .exclude(\.updateSearch)
      .eraseToAnyPublisher()
    let updateSearchAction = action
      .include(\.updateSearch)
      .removeDuplicates()
      .dropFirst(1)
      .eraseToAnyPublisher()
    return Publishers.MergeMany(
      actionWithoutUpdateSearch,
      updateSearchAction,
      updateSearchAction
        .debounce(for: 0.3, scheduler: scheduler)
        .removeDuplicates()
        .map { _ in .fetchAnimeList }
        .eraseToAnyPublisher()
    )
    .eraseToAnyPublisher()
  }

  public func mutate(action: Action) -> AnyPublisher<Mutation, Never> {
    switch action {
    case .fetchAnimeList:
      animeRepository
        .fetchAnimeList()
        .map { .fetchAnimeListSuccess($0) }
        .catch { Just(.fetchAnimeListError($0)) }
        .prepend(.fetchAnimeList)
        .eraseToAnyPublisher()
    case let .updateSearch(search):
      Just(.updateSearch(search))
        .eraseToAnyPublisher()
    }
  }

  public func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case let .updateSearch(search):
      newState.search = search
    case .fetchAnimeList:
      newState.isFetching = true
      newState.isError = false
    case let .fetchAnimeListSuccess(animes):
      newState.animes = animes
      newState.isFetching = false
    case .fetchAnimeListError:
      newState.isError = true
      newState.isFetching = false
    }
    return newState
  }
}
