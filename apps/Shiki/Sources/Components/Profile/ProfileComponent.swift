import AuthCore
import Foundation
import NeedleFoundation
import Network
import ProfileCore
import ProfileImplementation
import ProfileUI

public protocol ProfileDependency: Dependency {
  var authRepository: AuthRepository { get }
  var networkWithAuthorization: Network { get }
}

public final class ProfileComponent: Component<ProfileDependency> {
  public var profileGateway: ProfileGateway {
    shared {
      ProfileGatewayImplementation(network: dependency.networkWithAuthorization)
    }
  }

  public var profileRepository: ProfileRepository {
    shared {
      ProfileRepositoryImplementation(
        profileGateway: profileGateway,
        authRepository: dependency.authRepository
      )
    }
  }

  public var profileViewModel: ProfileViewModel {
    ProfileViewModel(
      profileRepository: profileRepository,
      authRepository: dependency.authRepository
    )
  }

  var profile: ProfileUI.Profile {
    Profile(viewModel: profileViewModel)
  }
}
