@resultBuilder
public struct StringBuilder {
  public static func buildBlock(_ parts: String...) -> String {
    parts.joined(separator: "")
  }

  public static func buildArray(_ components: [String]) -> String {
    components.joined(separator: "")
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

public extension String {
  init(@StringBuilder builder: () -> String) {
    self.init(stringLiteral: builder())
  }
}
