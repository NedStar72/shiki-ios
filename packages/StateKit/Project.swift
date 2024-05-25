import ProjectDescription
import ProjectDescriptionHelpers

public let StateKit = Target.staticFramework(
  name: "StateKit",
  sources: ["Sources/**"],
  dependencies: [
    .externalPackage("CombineSchedulers"),
    .package("SwiftUtils"),
    .package("CombineUtils"),
  ]
)
let StateKitTests = Target.unitTests(
  target: StateKit,
  sources: ["Tests/**"]
)

let StateKitPackage = Project(
  name: "StateKit",
  targets: [
    StateKit,
    StateKitTests,
  ]
)
