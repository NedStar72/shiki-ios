import ProjectDescription
import ProjectDescriptionHelpers

public let CombineUtils = Target.staticFramework(
  name: "CombineUtils",
  sources: ["Sources/**"],
  dependencies: [
    .externalPackage("CasePaths"),
  ]
)
let CombineUtilsTests = Target.unitTests(
  target: CombineUtils,
  sources: ["Tests/**"]
)

let CombineUtilsPackage = Project(
  name: "CombineUtils",
  targets: [
    CombineUtils,
    CombineUtilsTests,
  ]
)
