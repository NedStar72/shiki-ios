import Alamofire
import Foundation

public extension RequestInterceptor {
  func adapt(_ urlRequest: URLRequest,
             for _: Alamofire.Session,
             completion: @escaping (Result<URLRequest, Error>) -> Void) {
    Task {
      do {
        try await completion(.success(self.adapt(urlRequest)))
      } catch {
        completion(.failure(error))
      }
    }
  }

  func retry(_ request: Alamofire.Request,
             for _: Alamofire.Session,
             dueTo error: Error,
             completion: @escaping (Alamofire.RetryResult) -> Void) {
    guard let urlRequest = request.request else {
      completion(.doNotRetry)
      return
    }
    Task {
      await completion(retry(urlRequest, dueTo: error, response: request.response).alamofireValue)
    }
  }
}
