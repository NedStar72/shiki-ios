import Foundation
import SwiftUtils

public struct Query {
  var base: String = ""
  var path: [String] = []
  var params: [String: String] = [:]

  public var string: String {
    String(builder: {
      base
      if base.last != "/" {
        "/"
      }
      if !path.isEmpty {
        path.joined(separator: "/")
      }
      if !params.isEmpty {
        "?"
        params.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
      }
    })
  }

  public init(@QueryBuilder builder: () -> QueryComponent) {
    let component = builder()
    component.modify(&self)
  }

  public func toURL() -> URL? {
    URL(string: string)
  }
}
