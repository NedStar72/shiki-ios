import CasePaths
import Combine

public extension Publisher where Output: CasePathable {
  func include(_ keyPath: PartialCaseKeyPath<Output>) -> Publishers.Filter<Self> {
    filter { $0.is(keyPath) }
  }

  func exclude(_ keyPath: PartialCaseKeyPath<Output>) -> Publishers.Filter<Self> {
    filter { !$0.is(keyPath) }
  }
}
