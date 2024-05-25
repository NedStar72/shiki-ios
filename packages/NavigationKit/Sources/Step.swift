public protocol Step: Hashable, Identifiable {}

public extension Step {
  var id: Self {
    self
  }
}
