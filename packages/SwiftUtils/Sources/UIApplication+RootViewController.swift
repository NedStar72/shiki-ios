import UIKit

public extension UIApplication {
  @MainActor var rootViewController: UIViewController? {
    UIApplication.shared.connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .filter { $0.activationState == .foregroundActive }
      .first?
      .keyWindow?
      .rootViewController
  }
}
