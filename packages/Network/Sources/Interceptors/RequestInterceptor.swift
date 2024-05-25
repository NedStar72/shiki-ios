import Alamofire
import Foundation

public protocol RequestInterceptor: Alamofire.RequestInterceptor {
  func adapt(_ urlRequest: URLRequest) async throws -> URLRequest
  func retry(_ urlRequest: URLRequest, dueTo error: any Error, response: HTTPURLResponse?) async -> RetryResult
}
