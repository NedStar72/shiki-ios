import Alamofire

public typealias Method = HTTPMethod
public typealias Header = HTTPHeader

public enum NetworkError: Error {
  case noData
}

public class Network {
  private var session: Alamofire.Session

  public init(interceptor: RequestInterceptor? = nil) {
    session = Session(interceptor: interceptor)
  }

  public func request<Result: Decodable>(
    _: Result.Type = Result.self,
    _ query: Query,
    method: Method,
    headers: [Header] = [],
    parameters: [String: Any]? = nil
  ) async throws -> Result {
    let response = await session.request(query,
                                         method: method,
                                         parameters: parameters,
                                         headers: HTTPHeaders(headers))
      .validate()
      .serializingDecodable(Result.self)
      .response
    if let error = response.error {
      throw error
    }
    if let data = response.value {
      return data
    }
    throw NetworkError.noData
  }
}
