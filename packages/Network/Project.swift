import ProjectDescription
import ProjectDescriptionHelpers

public let Network = Target.staticFramework(
  name: "Network",
  sources: ["Sources/**"],
  dependencies: [
    .externalPackage("Alamofire"),
    .package("SwiftUtils"),
  ]
)
let NetworkTests = Target.unitTests(
  target: Network,
  sources: ["Tests/**"]
)

let NetworkPackage = Project(
  name: "Network",
  targets: [
    Network,
    NetworkTests,
  ]
)
