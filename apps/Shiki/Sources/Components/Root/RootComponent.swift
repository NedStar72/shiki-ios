import KeychainKit
import NeedleFoundation
import Network
import RootCore
import RootImplementation

public final class RootComponent: BootstrapComponent {
  public var keychain: Keychain {
    shared {
      Keychain()
    }
  }

  public var networkWithoutAuthorization: Network {
    shared {
      Network()
    }
  }

  public var appViewModel: AppViewModel {
    shared {
      AppViewModelImplementation()
    }
  }
}
