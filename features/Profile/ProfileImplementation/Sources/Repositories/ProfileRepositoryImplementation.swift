import AuthCore
import Combine
import CombineUtils
import ProfileCore

public class ProfileRepositoryImplementation: ProfileRepository {
  private var subscriptions: Set<AnyCancellable> = []

  private let profileGateway: ProfileGateway
  private let authRepository: AuthRepository

  // TODO: Publisher->Subject extension?
  public private(set) lazy var profile: AnyPublisher<Profile?, Never> = {
    let profileSubject = CurrentValueSubject<Profile?, Never>(nil)

    authRepository
      .isLoggedIn
      .flatMap { isLoggedIn in
        if isLoggedIn {
          Future { [unowned self] in
            try await profileGateway.fetchProfile()
          }
          .catch { _ in Just(nil) }
          .eraseToAnyPublisher()
        } else {
          Just<Profile?>(nil)
            .eraseToAnyPublisher()
        }
      }
      .subscribe(profileSubject)
      .store(in: &self.subscriptions)

    return profileSubject.eraseToAnyPublisher()
  }()

  public init(profileGateway: ProfileGateway, authRepository: AuthRepository) {
    self.profileGateway = profileGateway
    self.authRepository = authRepository
  }
}
