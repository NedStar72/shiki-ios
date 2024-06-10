import AuthCore
import Combine
import CombineUtils
import ProfileCore

typealias ProfileState = FutureState<Profile?, any Error>

public class ProfileRepositoryImplementation: ProfileRepository {
  private var subscriptions: Set<AnyCancellable> = []

  private let profileGateway: ProfileGateway
  private let authRepository: AuthRepository

  private lazy var profilePublisher: AnyPublisher<ProfileState, Never> = authRepository
    .isLoggedIn
    .flatMap { isLoggedIn in
      if isLoggedIn {
        Future<Profile?, any Error> { [unowned self] in
          try await Optional(profileGateway.fetchProfile())
        }
        .encase()
      } else {
        Just<ProfileState>(.fulfilled(nil))
          .eraseToAnyPublisher()
      }
    }
    .share()
    .eraseToAnyPublisher()

  public private(set) lazy var profile: AnyPublisher<Profile?, Never> = profilePublisher
    .flatMap { profileState in
      switch profileState {
      case let .fulfilled(profile):
        Just(profile)
          .eraseToAnyPublisher()
      default:
        Empty<Profile?, Never>()
          .eraseToAnyPublisher()
      }
    }
    .multicast { CurrentValueSubject(nil) }
    .autoconnect()
    .eraseToAnyPublisher()

  public private(set) lazy var profileState: AnyPublisher<Bool, Never> = profilePublisher
    .map { profileState in
      switch profileState {
      case .pending:
        true
      default:
        false
      }
    }
    .multicast { CurrentValueSubject(false) }
    .autoconnect()
    .eraseToAnyPublisher()

  public init(profileGateway: ProfileGateway, authRepository: AuthRepository) {
    self.profileGateway = profileGateway
    self.authRepository = authRepository
  }
}
