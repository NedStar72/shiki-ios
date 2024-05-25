public struct BaseURL: QueryComponent {
  private let baseURL: String

  public init(_ baseURL: String) {
    self.baseURL = baseURL
  }

  public func modify(_ query: inout Query) -> Query {
    query.base = baseURL
    return query
  }
}
