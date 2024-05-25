public struct Param: QueryComponent {
  private let key: String
  private let value: String

  public init(_ key: String, _ value: String) {
    self.key = key
    self.value = value
  }

  public func modify(_ query: inout Query) -> Query {
    query.params.updateValue(value, forKey: key)
    return query
  }
}
