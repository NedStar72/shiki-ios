

import AnimeCore
import AnimeImplementation
import AnimeUI
import AppAuth
import AuthCore
import AuthImplementation
import Foundation
import KeychainKit
import NeedleFoundation
import Network
import ProfileCore
import ProfileImplementation
import ProfileUI
import RootCore
import RootImplementation

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = "a04c4d398628a87e56ffb4da3bbc2669"

// MARK: - Traversal Helpers

private func parent1(_ component: NeedleFoundation.Scope) -> NeedleFoundation.Scope {
    return component.parent
}

// MARK: - Providers

#if !NEEDLE_DYNAMIC

private class ProfileDependency6818e92e498fe07e2622Provider: ProfileDependency {
    var authRepository: AuthRepository {
        return rootComponent.authRepository
    }
    var networkWithAuthorization: Network {
        return rootComponent.networkWithAuthorization
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->ProfileComponent
private func factory62ee3a75b16d091e8f01b3a8f24c1d289f2c0f2e(_ component: NeedleFoundation.Scope) -> AnyObject {
    return ProfileDependency6818e92e498fe07e2622Provider(rootComponent: parent1(component) as! RootComponent)
}
private class AnimeDependency61be1b5a6a46545d0f27Provider: AnimeDependency {
    var networkWithoutAuthorization: Network {
        return rootComponent.networkWithoutAuthorization
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->AnimeComponent
private func factoryf3b17029a109a6ffcadcb3a8f24c1d289f2c0f2e(_ component: NeedleFoundation.Scope) -> AnyObject {
    return AnimeDependency61be1b5a6a46545d0f27Provider(rootComponent: parent1(component) as! RootComponent)
}

#else
extension ProfileComponent: Registration {
    public func registerItems() {
        keyPathToName[\ProfileDependency.authRepository] = "authRepository-AuthRepository"
        keyPathToName[\ProfileDependency.networkWithAuthorization] = "networkWithAuthorization-Network"
    }
}
extension RootComponent: Registration {
    public func registerItems() {

        localTable["keychain-Keychain"] = { [unowned self] in self.keychain as Any }
        localTable["networkWithoutAuthorization-Network"] = { [unowned self] in self.networkWithoutAuthorization as Any }
        localTable["appViewModel-AppViewModel"] = { [unowned self] in self.appViewModel as Any }
        localTable["oauthRequest-OIDAuthorizationRequest"] = { [unowned self] in self.oauthRequest as Any }
        localTable["authGateway-AuthGateway"] = { [unowned self] in self.authGateway as Any }
        localTable["authRepository-AuthRepository"] = { [unowned self] in self.authRepository as Any }
        localTable["networkWithAuthorization-Network"] = { [unowned self] in self.networkWithAuthorization as Any }
    }
}
extension AnimeComponent: Registration {
    public func registerItems() {
        keyPathToName[\AnimeDependency.networkWithoutAuthorization] = "networkWithoutAuthorization-Network"
    }
}


#endif

private func factoryEmptyDependencyProvider(_ component: NeedleFoundation.Scope) -> AnyObject {
    return EmptyDependencyProvider(component: component)
}

// MARK: - Registration
private func registerProviderFactory(_ componentPath: String, _ factory: @escaping (NeedleFoundation.Scope) -> AnyObject) {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: componentPath, factory)
}

#if !NEEDLE_DYNAMIC

@inline(never) private func register1() {
    registerProviderFactory("^->RootComponent->ProfileComponent", factory62ee3a75b16d091e8f01b3a8f24c1d289f2c0f2e)
    registerProviderFactory("^->RootComponent", factoryEmptyDependencyProvider)
    registerProviderFactory("^->RootComponent->AnimeComponent", factoryf3b17029a109a6ffcadcb3a8f24c1d289f2c0f2e)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}
