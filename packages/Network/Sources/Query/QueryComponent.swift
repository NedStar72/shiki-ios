public protocol QueryComponent {
  @discardableResult func modify(_ query: inout Query) -> Query
}
