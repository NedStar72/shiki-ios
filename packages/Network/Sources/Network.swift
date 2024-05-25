import Alamofire

public enum NetworkError: Error {
  case noData
}

public class Network {
  private var session: Alamofire.Session

  public init(interceptor: RequestInterceptor? = nil) {
    session = Session(interceptor: interceptor)
  }

  public func request<Result: Decodable>(_: Result.Type = Result.self, _ request: Request) async throws -> Result {
    let response = await session.request(request)
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
