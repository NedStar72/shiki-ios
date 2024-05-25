import SwiftUI

public struct StackCoordinator<CoordinatorStep: Step>: ViewModifier {
  @State private var steps: [CoordinatorStep] = [] // TODO: вынести стейт в navigator

  public func body(content: Content) -> some View {
    NavigationStack(path: $steps) {
      content
    }
  }
}

public extension Coordinator {
  func stack() -> some View {
    modifier(StackCoordinator<CoordinatorStep>())
  }
}
