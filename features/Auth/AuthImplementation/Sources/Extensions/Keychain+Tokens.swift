import KeychainKit

let accessTokenKey = "accessTokenKey"
let refreshTokenKey = "refreshTokenKey"

extension Keychain {
  var accessToken: String? {
    get {
      // swiftformat:disable redundantSelf
      self.get(accessTokenKey)
    }
    set {
      if let newValue {
        self.set(newValue, forKey: accessTokenKey)
      } else {
        self.delete(accessTokenKey)
      }
    }
  }

  var refreshToken: String? {
    get {
      // swiftformat:disable redundantSelf
      self.get(refreshTokenKey)
    }
    set {
      if let newValue {
        self.set(newValue, forKey: refreshTokenKey)
      } else {
        self.delete(refreshTokenKey)
      }
    }
  }
}
