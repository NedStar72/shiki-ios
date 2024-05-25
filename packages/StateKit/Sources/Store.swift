import Combine
import CombineSchedulers
import CombineUtils
import SwiftUI

public typealias AnyDispatchQueueScheduler = AnyScheduler<DispatchQueue.SchedulerTimeType, DispatchQueue.SchedulerOptions>

/// A Store is an UI-independent layer which manages the state of a view. The foremost role of a
/// reactor is to separate control flow from a view. Every view has its corresponding reactor and
/// delegates all logic to its reactor.
public protocol Store: ObservableObject {
  /// An action represents user actions.
  associatedtype Action

  /// A mutation represents state changes.
  associatedtype Mutation

  /// A State represents the current state of a view.
  associatedtype State

  /// The initial state.
  var initialState: State { get }

  /// The current state. This value is changed just after the mutation stream emits a new state.
  var state: State { get }

  /// A scheduler for action and mutation streams. Defaults to `DispatchConcurrentQueue.global(qos: .userInitiated)`.
  var scheduler: AnyDispatchQueueScheduler { get }

  /// The action from the view. Bind user inputs to this subject.
  var action: AnySubject<Action, Never> { get }

  /// Transforms the action. Use this function to combine with other publishers. This method is
  /// called once before the state stream is created.
  func transform(action: AnyPublisher<Action, Never>) -> AnyPublisher<Action, Never>

  /// Commits mutation from the action. This is the best place to perform side-effects such as
  /// async tasks.
  func mutate(action: Action) -> AnyPublisher<Mutation, Never>

  /// Transforms the mutation stream. Implement this method to transform or combine with other
  /// publishers. This method is called once before the state stream is created.
  func transform(mutation: AnyPublisher<Mutation, Never>) -> AnyPublisher<Mutation, Never>

  /// Generates a new state with the previous state and the action. It should be purely functional
  /// so it should not perform any side-effects here. This method is called every time when the
  /// mutation is committed.
  func reduce(state: State, mutation: Mutation) -> State

  /// Transforms the state stream. Use this function to perform side-effects such as logging. This
  /// method is called once after the state stream is created.
  func transform(state: AnyPublisher<State, Never>) -> AnyPublisher<State, Never>
}
