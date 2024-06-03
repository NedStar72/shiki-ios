import Combine

public protocol ProfileRepository {
  var profile: AnyPublisher<Profile?, Never> { get }
}
