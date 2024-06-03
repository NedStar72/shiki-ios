import ProjectDescription
import ProjectDescriptionHelpers

public let ProfileCore = Target.staticFramework(
  name: "ProfileCore",
  sources: ["ProfileCore/Sources/**"]
)
public let ProfileImplementation = Target.staticFramework(
  name: "ProfileImplementation",
  sources: ["ProfileImplementation/Sources/**"],
  dependencies: [
    .package("SwiftUtils"),
    .package("CombineUtils"),
    .package("Network"),
    .feature(project: "Auth", name: "AuthCore"),
    .target(ProfileCore),
  ]
)
let ProfileImplementationTests = Target.unitTests(
  target: ProfileImplementation,
  sources: ["ProfileImplementation/Tests/**"]
)
public let ProfileUI = Target.staticFramework(
  name: "ProfileUI",
  sources: ["ProfileUI/Sources/**"],
  dependencies: [
    .externalPackage("CasePaths"),
    .package("ShikiUIKit"),
    .package("StateKit"),
    .feature(project: "Auth", name: "AuthCore"),
    .target(ProfileCore),
  ]
)
let ProfileUITests = Target.unitTests(
  target: ProfileUI,
  sources: ["ProfileUI/Tests/**"]
)

let ProfileFeature = Project(
  name: "Profile",
  targets: [
    ProfileCore,
    ProfileImplementation,
    ProfileImplementationTests,
    ProfileUI,
    ProfileUITests,
  ]
)
