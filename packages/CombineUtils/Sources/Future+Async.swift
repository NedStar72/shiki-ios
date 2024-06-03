import Combine

public extension Future where Failure == Error {
  convenience init(operation: @escaping () async throws -> Output) {
    self.init { promise in
      // TODO: как отменить эту таску?
      Task {
        do {
          let output = try await operation()
          promise(.success(output))
        } catch {
          promise(.failure(error))
        }
      }
    }
  }
}
