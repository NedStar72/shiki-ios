import ProjectDescription
import ProjectDescriptionHelpers

public let KeychainKit = Target.staticFramework(
  name: "KeychainKit",
  sources: ["Sources/**"]
)
let KeychainKitTests = Target.unitTests(
  target: KeychainKit,
  sources: ["Tests/**"]
)

let KeychainKitPackage = Project(
  name: "KeychainKit",
  targets: [
    KeychainKit,
    KeychainKitTests,
  ]
)
