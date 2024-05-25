import ProjectDescription

public let DefaultDestinations: ProjectDescription.Destinations = .iOS
public let DefaultDeploymentTargets: ProjectDescription.DeploymentTargets = .iOS("17.0")

public extension Target {
  static func app(
    name: String,
    destinations: ProjectDescription.Destinations = DefaultDestinations,
    deploymentTargets: ProjectDescription.DeploymentTargets = DefaultDeploymentTargets,
    extraInfoPlist: [String: Plist.Value] = [:],
    sources: ProjectDescription.SourceFilesList,
    resources: ProjectDescription.ResourceFileElements = [],
    copyFiles _: [ProjectDescription.CopyFilesAction]? = nil,
    headers _: ProjectDescription.Headers? = nil,
    entitlements _: ProjectDescription.Entitlements? = nil,
    scripts: [ProjectDescription.TargetScript] = [],
    dependencies: [ProjectDescription.TargetDependency] = [],
    settings: ProjectDescription.Settings? = nil,
    coreDataModels: [ProjectDescription.CoreDataModel] = [],
    environmentVariables: [String: ProjectDescription.EnvironmentVariable] = [:],
    launchArguments: [ProjectDescription.LaunchArgument] = [],
    additionalFiles: [ProjectDescription.FileElement] = [],
    buildRules: [ProjectDescription.BuildRule] = [],
    mergedBinaryType: ProjectDescription.MergedBinaryType = .disabled,
    mergeable: Bool = false
  ) -> Target {
    target(
      name: name,
      destinations: destinations,
      product: .app,
      bundleId: "dev.nedstar.\(name.lowercased())",
      deploymentTargets: deploymentTargets,
      infoPlist: .extendingDefault(with: extraInfoPlist),
      sources: sources,
      resources: resources,
      scripts: scripts,
      dependencies: dependencies,
      settings: settings,
      coreDataModels: coreDataModels,
      environmentVariables: environmentVariables,
      launchArguments: launchArguments,
      additionalFiles: additionalFiles,
      buildRules: buildRules,
      mergedBinaryType: mergedBinaryType,
      mergeable: mergeable
    )
  }

  static func unitTests(
    target: Target,
    extraInfoPlist: [String: Plist.Value] = [:],
    sources: ProjectDescription.SourceFilesList,
    resources: ProjectDescription.ResourceFileElements = [],
    copyFiles _: [ProjectDescription.CopyFilesAction]? = nil,
    headers _: ProjectDescription.Headers? = nil,
    entitlements _: ProjectDescription.Entitlements? = nil,
    scripts: [ProjectDescription.TargetScript] = [],
    settings: ProjectDescription.Settings? = nil,
    coreDataModels: [ProjectDescription.CoreDataModel] = [],
    environmentVariables: [String: ProjectDescription.EnvironmentVariable] = [:],
    launchArguments: [ProjectDescription.LaunchArgument] = [],
    additionalFiles: [ProjectDescription.FileElement] = [],
    buildRules: [ProjectDescription.BuildRule] = [],
    mergedBinaryType: ProjectDescription.MergedBinaryType = .disabled,
    mergeable: Bool = false
  ) -> Target {
    self.target(
      name: "\(target.name)Tests",
      destinations: target.destinations,
      product: .unitTests,
      bundleId: "dev.nedstar.\(target.name.lowercased()).tests",
      deploymentTargets: target.deploymentTargets,
      infoPlist: .extendingDefault(with: extraInfoPlist),
      sources: sources,
      resources: resources,
      scripts: scripts,
      dependencies: [.target(target)],
      settings: settings,
      coreDataModels: coreDataModels,
      environmentVariables: environmentVariables,
      launchArguments: launchArguments,
      additionalFiles: additionalFiles,
      buildRules: buildRules,
      mergedBinaryType: mergedBinaryType,
      mergeable: mergeable
    )
  }

  static func staticFramework(
    name: String,
    destinations: ProjectDescription.Destinations = DefaultDestinations,
    deploymentTargets: ProjectDescription.DeploymentTargets = DefaultDeploymentTargets,
    extraInfoPlist: [String: Plist.Value] = [:],
    sources: ProjectDescription.SourceFilesList,
    resources: ProjectDescription.ResourceFileElements = [],
    copyFiles _: [ProjectDescription.CopyFilesAction]? = nil,
    headers _: ProjectDescription.Headers? = nil,
    entitlements _: ProjectDescription.Entitlements? = nil,
    scripts: [ProjectDescription.TargetScript] = [],
    dependencies: [ProjectDescription.TargetDependency] = [],
    settings: ProjectDescription.Settings? = nil,
    coreDataModels: [ProjectDescription.CoreDataModel] = [],
    environmentVariables: [String: ProjectDescription.EnvironmentVariable] = [:],
    launchArguments: [ProjectDescription.LaunchArgument] = [],
    additionalFiles: [ProjectDescription.FileElement] = [],
    buildRules: [ProjectDescription.BuildRule] = [],
    mergedBinaryType: ProjectDescription.MergedBinaryType = .disabled,
    mergeable: Bool = false
  ) -> Target {
    target(
      name: name,
      destinations: destinations,
      product: .staticFramework,
      bundleId: "dev.nedstar.\(name.lowercased())",
      deploymentTargets: deploymentTargets,
      infoPlist: .extendingDefault(with: extraInfoPlist),
      sources: sources,
      resources: resources,
      scripts: scripts,
      dependencies: dependencies,
      settings: settings,
      coreDataModels: coreDataModels,
      environmentVariables: environmentVariables,
      launchArguments: launchArguments,
      additionalFiles: additionalFiles,
      buildRules: buildRules,
      mergedBinaryType: mergedBinaryType,
      mergeable: mergeable
    )
  }

  static func dynamicFramework(
    name: String,
    destinations: ProjectDescription.Destinations = DefaultDestinations,
    deploymentTargets: ProjectDescription.DeploymentTargets = DefaultDeploymentTargets,
    extraInfoPlist: [String: Plist.Value] = [:],
    sources: ProjectDescription.SourceFilesList,
    resources: ProjectDescription.ResourceFileElements = [],
    copyFiles _: [ProjectDescription.CopyFilesAction]? = nil,
    headers _: ProjectDescription.Headers? = nil,
    entitlements _: ProjectDescription.Entitlements? = nil,
    scripts: [ProjectDescription.TargetScript] = [],
    dependencies: [ProjectDescription.TargetDependency] = [],
    settings: ProjectDescription.Settings? = nil,
    coreDataModels: [ProjectDescription.CoreDataModel] = [],
    environmentVariables: [String: ProjectDescription.EnvironmentVariable] = [:],
    launchArguments: [ProjectDescription.LaunchArgument] = [],
    additionalFiles: [ProjectDescription.FileElement] = [],
    buildRules: [ProjectDescription.BuildRule] = [],
    mergedBinaryType: ProjectDescription.MergedBinaryType = .disabled,
    mergeable: Bool = false
  ) -> Target {
    target(
      name: name,
      destinations: destinations,
      product: .framework,
      bundleId: "dev.nedstar.\(name.lowercased())",
      deploymentTargets: deploymentTargets,
      infoPlist: .extendingDefault(with: extraInfoPlist),
      sources: sources,
      resources: resources,
      scripts: scripts,
      dependencies: dependencies,
      settings: settings,
      coreDataModels: coreDataModels,
      environmentVariables: environmentVariables,
      launchArguments: launchArguments,
      additionalFiles: additionalFiles,
      buildRules: buildRules,
      mergedBinaryType: mergedBinaryType,
      mergeable: mergeable
    )
  }
}
