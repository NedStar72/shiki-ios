import ProjectDescription
import ProjectDescriptionHelpers

public let AuthCore = Target.staticFramework(
  name: "AuthCore",
  sources: ["AuthCore/Sources/**"]
)
public let AuthImplementation = Target.staticFramework(
  name: "AuthImplementation",
  sources: ["AuthImplementation/Sources/**"],
  dependencies: [
    .externalPackage("AppAuth"),
    .package("SwiftUtils"),
    .package("CombineUtils"),
    .package("Network"),
    .target(AuthCore),
  ]
)
let AuthImplementationTests = Target.unitTests(
  target: AuthImplementation,
  sources: ["AuthImplementation/Tests/**"]
)
public let AuthUI = Target.staticFramework(
  name: "AuthUI",
  sources: ["AuthUI/Sources/**"],
  dependencies: [
    .target(AuthCore),
  ]
)
let AuthUITests = Target.unitTests(
  target: AuthUI,
  sources: ["AuthUI/Tests/**"]
)

let AuthFeature = Project(
  name: "Auth",
  targets: [
    AuthCore,
    AuthImplementation,
    AuthImplementationTests,
    AuthUI,
    AuthUITests,
  ]
)
