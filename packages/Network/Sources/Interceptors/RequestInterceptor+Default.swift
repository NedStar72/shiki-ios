import Foundation

public extension RequestInterceptor {
  func adapt(_ urlRequest: URLRequest) async throws -> URLRequest {
    urlRequest
  }

  func retry(_: URLRequest, dueTo _: any Error) async -> RetryResult {
    .doNotRetry
  }
}