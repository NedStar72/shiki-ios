import KeychainKit
import NeedleFoundation
import Network

final class RootComponent: BootstrapComponent {
  public var keychain: Keychain {
    shared {
      Keychain()
    }
  }

  public var networkNoAuthorization: Network {
    shared {
      Network()
    }
  }
}
