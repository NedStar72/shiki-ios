import ProjectDescription
import ProjectDescriptionHelpers

public let RootCore = Target.staticFramework(
  name: "RootCore",
  sources: ["RootCore/Sources/**"]
)
public let RootImplementation = Target.staticFramework(
  name: "RootImplementation",
  sources: ["RootImplementation/Sources/**"],
  dependencies: [
    .target(RootCore),
  ]
)
let RootImplementationTests = Target.unitTests(
  target: RootImplementation,
  sources: ["RootImplementation/Tests/**"]
)
public let RootUI = Target.staticFramework(
  name: "RootUI",
  sources: ["RootUI/Sources/**"],
  dependencies: [
    .target(RootCore),
  ]
)
let RootUITests = Target.unitTests(
  target: RootUI,
  sources: ["RootUI/Tests/**"]
)

let RootFeature = Project(
  name: "Root",
  targets: [
    RootCore,
    RootImplementation,
    RootImplementationTests,
    RootUI,
    RootUITests,
  ]
)
