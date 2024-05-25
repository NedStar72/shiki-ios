import Foundation
import ProjectDescription

let workspaceRootPath = URL(fileURLWithPath: #file).pathComponents.dropLast(3).joined(separator: "/").dropFirst()
let featuresPath = "\(workspaceRootPath)/features"
let packagesPath = "\(workspaceRootPath)/packages"

public extension TargetDependency {
  static func externalPackage(_ name: String) -> Self {
    .external(name: name, condition: .none)
  }

  static func package(_ name: String) -> Self {
    .project(target: name, path: "\(packagesPath)/\(name)")
  }

  static func feature(project: String, name: String) -> Self {
    .project(target: name, path: "\(featuresPath)/\(project)")
  }
}
