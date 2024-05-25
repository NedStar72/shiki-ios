import ProjectDescription
import ProjectDescriptionHelpers

public let SwiftUtils = Target.staticFramework(
  name: "SwiftUtils",
  sources: ["Sources/**"]
)
let SwiftUtilsTests = Target.unitTests(
  target: SwiftUtils,
  sources: ["Tests/**"]
)

let SwiftUtilsPackage = Project(
  name: "SwiftUtils",
  targets: [
    SwiftUtils,
    SwiftUtilsTests,
  ]
)
