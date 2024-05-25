import SwiftUI

public struct Coordinator<CoordinatorStep: Step, Destination: View>: View {
  var initialStep: CoordinatorStep
  var destination: (_ step: CoordinatorStep) -> Destination

  public init(
    initialStep: CoordinatorStep,
    @ViewBuilder destination: @escaping (_ step: CoordinatorStep) -> Destination
  ) {
    self.initialStep = initialStep
    self.destination = destination
  }

  public var body: some View {
    destination(initialStep)
      .navigationDestination(for: CoordinatorStep.self) { step in
        destination(step)
      }
  }
}
