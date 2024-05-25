import SwiftUI

struct MountModifier: ViewModifier {
  @State private var didMount = false
  let effect: () -> Void

  init(_ effect: @escaping () -> Void) {
    self.effect = effect
  }

  func body(content: Content) -> some View {
    content.onAppear {
      if !didMount {
        effect()
      }
      didMount = true
    }
  }
}

public extension View {
  func onMount(_ effect: @escaping () -> Void) -> some View {
    modifier(MountModifier(effect))
  }
}
