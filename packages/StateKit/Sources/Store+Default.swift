import Combine
import CombineSchedulers
import CombineUtils
import SwiftUI
import SwiftUtils

private enum SharedWeakStore {
  static let action = WeakMapTable<AnyObject, AnyObject>()
  static let state = WeakMapTable<AnyObject, Any>()
  static let subscriptions = WeakMapTable<AnyObject, [AnyCancellable]>()
}

public extension Store where Self.ObjectWillChangePublisher == ObservableObjectPublisher {
  private var subscriptions: [AnyCancellable] {
    get { SharedWeakStore.subscriptions.forceCastedValue(forKey: self, default: []) }
    set { SharedWeakStore.subscriptions.setValue(newValue, forKey: self) }
  }

  private var _action: AnySubject<Action, Never> {
    SharedWeakStore.action.forceCastedValue(forKey: self, default: createActionSubject())
  }

  var state: State {
    SharedWeakStore.state.forceCastedValue(forKey: self, default: initialState)
  }

  var scheduler: AnyDispatchQueueScheduler {
    DispatchConcurrentQueue.global(qos: .userInitiated).eraseToAnyScheduler()
  }

  var action: AnySubject<Action, Never> {
    _action
  }

  func transform(action: AnyPublisher<Action, Never>) -> AnyPublisher<Action, Never> {
    action
  }

  func transform(mutation: AnyPublisher<Mutation, Never>) -> AnyPublisher<Mutation, Never> {
    mutation
  }

  func transform(state: AnyPublisher<State, Never>) -> AnyPublisher<State, Never> {
    state
  }

  private func createActionSubject() -> AnySubject<Action, Never> {
    let action = PassthroughSubject<Action, Never>().eraseToAnySubject()
    createActionStream(action: action)
    return action
  }

  private func createActionStream(action: AnySubject<Action, Never>) {
    let action = action
      .receive(on: scheduler)
      .eraseToAnyPublisher()
    let transformedAction = transform(action: action).eraseToAnyPublisher()
    let mutation = transformedAction
      .flatMap { [weak self] action -> AnyPublisher<Mutation, Never> in
        guard let self else { return Empty().eraseToAnyPublisher() }
        return mutate(action: action)
      }
      .eraseToAnyPublisher()
    let transformedMutation = transform(mutation: mutation)
    let state = transformedMutation
      .scan(initialState) { [weak self] state, mutation in
        guard let self else { return state }
        return reduce(state: state, mutation: mutation)
      }
      .eraseToAnyPublisher()
    transform(state: state)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        guard let self else { return }
        objectWillChange.send()
        SharedWeakStore.state.setValue(state, forKey: self)
      }
      .store(in: &subscriptions)
  }
}
