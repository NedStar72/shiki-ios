import ProjectDescription
import ProjectDescriptionHelpers

public let AnimeCore = Target.staticFramework(
  name: "AnimeCore",
  sources: ["AnimeCore/Sources/**"]
)
public let AnimeImplementation = Target.staticFramework(
  name: "AnimeImplementation",
  sources: ["AnimeImplementation/Sources/**"],
  dependencies: [
    // .externalPackage("MetaCodable"),
    .package("SwiftUtils"),
    .package("CombineUtils"),
    .package("Network"),
    .target(AnimeCore),
  ]
)
let AnimeImplementationTests = Target.unitTests(
  target: AnimeImplementation,
  sources: ["AnimeImplementation/Tests/**"]
)
public let AnimeUI = Target.staticFramework(
  name: "AnimeUI",
  sources: ["AnimeUI/Sources/**"],
  dependencies: [
    .externalPackage("CasePaths"),
    .package("ShikiUIKit"),
    .package("StateKit"),
    .target(AnimeCore),
  ]
)
let AnimeUITests = Target.unitTests(
  target: AnimeUI,
  sources: ["AnimeUI/Tests/**"]
)

let AnimeFeature = Project(
  name: "Anime",
  targets: [
    AnimeCore,
    AnimeImplementation,
    AnimeImplementationTests,
    AnimeUI,
    AnimeUITests,
  ]
)
