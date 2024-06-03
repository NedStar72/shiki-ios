import AuthCore
import Combine
import CombineUtils
import ProfileCore
import StateKit

public class ProfileViewModel: Store {
  private var profileRepository: ProfileRepository
  private var authRepository: AuthRepository

  public struct State {
    var profile: ProfileCore.Profile?
  }

  public let initialState: State = .init()

  public init(profileRepository: ProfileRepository, authRepository: AuthRepository) {
    self.profileRepository = profileRepository
    self.authRepository = authRepository
  }

  public enum Action: Equatable {
    case initial
    case login
    case logout
  }

  public enum Mutation {
    case setProfile(ProfileCore.Profile?)
    case login
    case logout
  }

  public func transform(action: AnyPublisher<Action, Never>) -> AnyPublisher<Action, Never> {
    action
      .print("Action")
      .eraseToAnyPublisher()
  }

  public func mutate(action: Action) -> AnyPublisher<Mutation, Never> {
    switch action {
    case .initial:
      profileRepository
        .profile
        .map { .setProfile($0) }
        .eraseToAnyPublisher()
    case .login:
      authRepository
        .login()
        .map { _ in .login }
        .catch { _ in Just(.login) }
        .eraseToAnyPublisher()
    case .logout:
      authRepository
        .logout()
        .map { _ in .logout }
        .catch { _ in Just(.logout) }
        .eraseToAnyPublisher()
    }
  }

  public func transform(mutation: AnyPublisher<Mutation, Never>) -> AnyPublisher<Mutation, Never> {
    mutation
      .print("Mutation")
      .eraseToAnyPublisher()
  }

  public func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case let .setProfile(profile):
      newState.profile = profile
    case .login, .logout:
      break
    }
    return newState
  }
}
