import ProjectDescription
import ProjectDescriptionHelpers

let Shiki = Target.app(
  name: "Shiki",
  extraInfoPlist: [
    "UILaunchStoryboardName": "LaunchScreen.storyboard",
    "CFBundleURLTypes": [
      ["CFBundleURLSchemes": ["dev.nedstar.shiki"]],
    ],
  ],
  sources: ["Sources/**"],
  resources: ["Resources/**"]
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
