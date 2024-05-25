import KeychainKit
import NeedleFoundation

final class RootComponent: BootstrapComponent {
  public var keychain: Keychain {
    shared {
      Keychain()
    }
  }
}
