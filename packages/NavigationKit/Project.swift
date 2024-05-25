import ProjectDescription
import ProjectDescriptionHelpers

public let NavigationKit = Target.staticFramework(
  name: "NavigationKit",
  sources: ["Sources/**"]
)
let NavigationKitTests = Target.unitTests(
  target: NavigationKit,
  sources: ["Tests/**"]
)

let NavigationKitPackage = Project(
  name: "NavigationKit",
  targets: [
    NavigationKit,
    NavigationKitTests,
  ]
)
