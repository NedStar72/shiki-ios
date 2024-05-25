@resultBuilder
public struct QueryBuilder {
  public static func buildBlock(_ component: QueryComponent...) -> QueryComponent {
    Box(component)
  }

  public static func buildOptional(_ component: QueryComponent?) -> QueryComponent {
    component ?? Empty()
  }

  public static func buildEither(first component: QueryComponent) -> QueryComponent {
    component
  }

  public static func buildEither(second component: QueryComponent) -> QueryComponent {
    component
  }
}
