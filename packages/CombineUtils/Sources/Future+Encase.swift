import Combine

public enum FutureState<Value, Failure> where Failure: Error {
  case pending
  case fulfilled(Value)
  case rejected(Failure)
}

// TODO: перейти на struct как в .map
public extension Future where Failure == Error {
  func encase() -> AnyPublisher<FutureState<Output, Failure>, Never> {
    map { FutureState.fulfilled($0) }
      .catch { Just<FutureState>(.rejected($0)) }
      .prepend(.pending)
      .eraseToAnyPublisher()
  }
}
