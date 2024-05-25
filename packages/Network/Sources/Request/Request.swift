import Alamofire
import Foundation

public typealias Method = HTTPMethod
public typealias Header = HTTPHeader

public enum RequestError: Error {
  case incorrectQuery(Query)
}

public struct Request {
  private let query: Query
  private let method: Method
  private let headers: [Header]

  public init(query: Query, method: Method, headers: [Header] = []) {
    self.query = query
    self.method = method
    self.headers = headers
  }
}

extension Request: URLRequestConvertible {
  public func asURLRequest() throws -> URLRequest {
    guard let url = query.toURL() else {
      throw RequestError.incorrectQuery(query)
    }
    return try URLRequest(url: url, method: method, headers: .init(headers))
  }
}
