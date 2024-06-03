import AppAuth
import AuthCore
import AuthImplementation
import Foundation
import NeedleFoundation
import Network

// TODO: extension?
let OAUTH2_CLIENT_ID = ProcessInfo.processInfo.environment["OAUTH2_CLIENT_ID"] ?? ""
let OAUTH2_CLIENT_SECRET = ProcessInfo.processInfo.environment["OAUTH2_CLIENT_SECRET"] ?? ""
let urlScheme = ProcessInfo.processInfo.environment["APP_URL_SCHEME"] ?? ""

let authorizationEndpoint = URL(string: "https://shikimori.one/oauth/authorize")!
let tokenEndpoint = URL(string: "https://shikimori.one/oauth/token")!

public extension RootComponent {
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

  internal var authGateway: AuthGateway {
    AuthGatewayImplementation(
      clientID: OAUTH2_CLIENT_ID,
      clientSecret: OAUTH2_CLIENT_SECRET,
      network: networkWithoutAuthorization
    )
  }

  var authRepository: AuthRepository {
    shared {
      AuthRepositoryImplementation(
        keychain: keychain,
        deepLinks: appViewModel.deepLinks,
        oauthRequest: oauthRequest,
        authGateway: authGateway
      )
    }
  }

  var networkWithAuthorization: Network {
    shared {
      Network(
        interceptor: AccessTokenInterceptor(
          keychain: keychain,
          authRepository: authRepository
        )
      )
    }
  }
}
