import Alamofire
import Foundation

public enum QueryError: Error {
  case incorrectQuery(Query)
}

extension Query: URLConvertible {
  public func asURL() throws -> URL {
    guard let url = URL(string: string) else {
      throw QueryError.incorrectQuery(self)
    }
    return url
  }
}
