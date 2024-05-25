import ProjectDescription

extension String {
  func camelCased(with separator: Character) -> String {
    lowercased()
      .split(separator: separator)
      .enumerated()
      .map { $0.offset > 0 ? $0.element.capitalized : $0.element.lowercased() }
      .joined()
  }
}

public extension EnvironmentVariable {
  /// Creates environment value from an external environment value
  /// - Parameter name: screaming snake case environment value name
  /// - Returns: EnvironmentVariable
  static func inherited(_ name: String) -> Self {
    .init(stringLiteral: Environment[dynamicMember: name.camelCased(with: "_")].getString(default: name))
  }

  static func plain(_ value: String, isEnabled: Bool = true) -> Self {
    .environmentVariable(value: value, isEnabled: isEnabled)
  }
}
