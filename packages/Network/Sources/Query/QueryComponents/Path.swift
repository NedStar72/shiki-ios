private let separator = "/"

public struct Path: QueryComponent {
  private let elements: [String]

  public init(@PathBuilder builder: () -> String) {
    elements = builder().split(separator: separator).map { String($0) }
  }

  public func modify(_ query: inout Query) -> Query {
    query.path = elements
    return query
  }
}

@resultBuilder
public struct PathBuilder {
  public static func buildBlock(_ component: String...) -> String {
    component
      .filter { !$0.isEmpty }
      .joined(separator: separator)
  }

  public static func buildOptional(_ component: String?) -> String {
    component ?? ""
  }

  public static func buildEither(first component: String) -> String {
    component
  }

  public static func buildEither(second component: String) -> String {
    component
  }
}
