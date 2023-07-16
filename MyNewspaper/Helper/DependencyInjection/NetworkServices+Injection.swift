
import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        registerMyNetworkServices()
    }
}

extension Resolver {
    public static func registerMyNetworkServices() {
        // register network service
        Resolver.register { NetworkService(userSession: UserSession(keychain: Resolver.resolve())) as NetworkServiceProtocol }
        Resolver.register { KeychainService() as KeychainProtocol }
        DILoginRegister.register()
        DITimelineRegister.register()
    }
}
