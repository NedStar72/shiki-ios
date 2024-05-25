import ProjectDescription
import ProjectDescriptionHelpers

let needleGenerationScript = TargetScript.pre(
  script: """
  export SOURCEKIT_LOGGING=0 && ../../tools/needle generate Generated/NeedleGenerated.swift Sources/ \
    --pluginized
  """,
  name: "Needle Generation Phase",
  outputPaths: [.path("Generated/NeedleGenerated.swift")]
)

let Shiki = Target.app(
  name: "Shiki",
  extraInfoPlist: [
    "UILaunchStoryboardName": "LaunchScreen.storyboard",
    "CFBundleURLTypes": [
      ["CFBundleURLSchemes": ["dev.nedstar.shiki"]],
    ],
  ],
  sources: ["Sources/**", "Generated/**"],
  resources: ["Resources/**"],
  scripts: [needleGenerationScript],
  dependencies: [
    .externalPackage("NeedleFoundation"),
    .package("KeychainKit"),
    .package("Network"),
  ]
)

let ShikiTests = Target.unitTests(
  target: Shiki,
  sources: ["Tests/**"]
)

let ShikiApp = Project(
  name: "Shiki",
  targets: [
    Shiki,
    ShikiTests,
  ]
)
