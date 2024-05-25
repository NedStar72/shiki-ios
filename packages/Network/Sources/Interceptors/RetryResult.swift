import Alamofire
import Foundation

/// Outcome of determination whether retry is necessary.
public enum RetryResult {
  /// Retry should be attempted immediately.
  case retry
  /// Retry should be attempted after the associated `TimeInterval`.
  case retryWithDelay(TimeInterval)
  /// Do not retry.
  case doNotRetry
  /// Do not retry due to the associated `Error`.
  case doNotRetryWithError(Error)
}

extension RetryResult {
  var alamofireValue: Alamofire.RetryResult {
    switch self {
      case .retry: .retry
      case let .retryWithDelay(timeInterval): .retryWithDelay(timeInterval)
      case .doNotRetry: .doNotRetry
      case let .doNotRetryWithError(error): .doNotRetryWithError(error)
    }
  }
}
