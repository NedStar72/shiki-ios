// swift-tools-version: 5.9
import PackageDescription

#if TUIST
  import ProjectDescription

  let packageSettings = PackageSettings(
    // Customize the product types for specific package product
    // Default is .staticFramework
    // productTypes: ["Alamofire": .framework,]
    productTypes: [:]
  )
#endif

let package = Package(
  name: "ShikiWorkspacePackages",
  dependencies: [
    .package(url: "https://github.com/uber/needle.git", .upToNextMinor(from: "0.24.0")),
    .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.9.1")),
    .package(url: "https://github.com/openid/AppAuth-iOS.git", .upToNextMajor(from: "1.3.0")),
    .package(url: "https://github.com/pointfreeco/combine-schedulers.git", .upToNextMajor(from: "1.0.0")),
    .package(url: "https://github.com/pointfreeco/swift-case-paths.git", .upToNextMajor(from: "1.3.3")),
    // .package(url: "https://github.com/SwiftyLab/MetaCodable.git", .upToNextMajor(from: "1.3.0")),
  ]
)
