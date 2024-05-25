import Combine
import Foundation

public protocol AppViewModel {
  var deepLinks: AnyPublisher<URL, Never> { get }

  func handle(url: URL)
}
