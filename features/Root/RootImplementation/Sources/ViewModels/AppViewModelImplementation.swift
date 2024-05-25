import Combine
import Foundation
import RootCore
import SwiftUI

let urlScheme = ProcessInfo.processInfo.environment["APP_URL_SCHEME"] ?? ""

public class AppViewModelImplementation: AppViewModel {
  private var deepLinkSubject = PassthroughSubject<URL, Never>()

  public var deepLinks: AnyPublisher<URL, Never> {
    deepLinkSubject.eraseToAnyPublisher()
  }

  public init() {}

  /// Handles the incoming URL and performs validations before acknowledging.
  public func handle(url: URL) {
    if url.scheme == urlScheme {
      deepLinkSubject.send(url)
    }
  }
}
