import ProjectDescription
import ProjectDescriptionHelpers

public let ShikiUIKit = Target.dynamicFramework(
  name: "ShikiUIKit",
  sources: ["Sources/**"]
)
let ShikiUIKitTests = Target.unitTests(
  target: ShikiUIKit,
  sources: ["Tests/**"]
)

let ShikiUIKitPackage = Project(
  name: "ShikiUIKit",
  targets: [
    ShikiUIKit,
    ShikiUIKitTests,
  ]
)
