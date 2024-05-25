import ProjectDescription
import ProjectDescriptionHelpers

let urlScheme = "dev.nedstar.shiki"

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
      ["CFBundleURLSchemes": [.string(urlScheme)]],
    ],
  ],
  sources: ["Sources/**", "Generated/**"],
  resources: ["Resources/**"],
  scripts: [needleGenerationScript],
  dependencies: [
    .externalPackage("NeedleFoundation"),
    .package("KeychainKit"),
    .package("Network"),
    .package("NavigationKit"),
    .feature(project: "Root", name: "RootCore"),
    .feature(project: "Root", name: "RootImplementation"),
    .feature(project: "Root", name: "RootUI"),
    .feature(project: "Auth", name: "AuthCore"),
    .feature(project: "Auth", name: "AuthImplementation"),
    .feature(project: "Auth", name: "AuthUI"),
  ],
  environmentVariables: [
    "APP_URL_SCHEME": .plain(urlScheme),
    "OAUTH2_CLIENT_ID": .inherited("OAUTH2_CLIENT_ID"),
    "OAUTH2_CLIENT_SECRET": .inherited("OAUTH2_CLIENT_SECRET"),
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
