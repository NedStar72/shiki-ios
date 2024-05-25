import AppAuth
import AuthCore
import AuthImplementation
import Foundation
import NeedleFoundation
import Network

let OAUTH2_CLIENT_ID = ProcessInfo.processInfo.environment["OAUTH2_CLIENT_ID"] ?? ""
let OAUTH2_CLIENT_SECRET = ProcessInfo.processInfo.environment["OAUTH2_CLIENT_SECRET"] ?? ""
let urlScheme = ProcessInfo.processInfo.environment["APP_URL_SCHEME"] ?? ""
let authorizationEndpoint = URL(string: "https://shikimori.one/oauth/authorize")!
let tokenEndpoint = URL(string: "https://shikimori.one/oauth/token")!

public extension RootComponent {
  var networkWithAuthorization: Network {
    shared {
      Network(
        interceptor: AccessTokenInterceptor(
          keychain: keychain
        )
      )
    }
  }

  internal var oauthRequest: OIDAuthorizationRequest {
    OIDAuthorizationRequest(
      configuration: OIDServiceConfiguration(
        authorizationEndpoint: authorizationEndpoint,
        tokenEndpoint: tokenEndpoint
      ),
      clientId: OAUTH2_CLIENT_ID,
      clientSecret: OAUTH2_CLIENT_SECRET,
      scopes: ["user_rates", "comments", "topics"],
      redirectURL: URL(string: "\(urlScheme)://oauth")!,
      responseType: "code",
      additionalParameters: nil
    )
  }

  var authRepository: AuthRepository {
    shared {
      AuthRepositoryImplementation(
        keychain: keychain,
        deepLinks: appViewModel.deepLinks,
        oauthRequest: oauthRequest
      )
    }
  }
}
