
import Foundation
import Resolver

class DITimelineRegister {
    
    static func register() {
        Resolver.register { ArticlesRemote(networkService: Resolver.resolve()) as  ArticlesRemoteProtocol }
        Resolver.register { ArticlesRepository(remote: Resolver.resolve()) as  ArticlesRepositoryProtocol }
        Resolver.register { ArticlesUsecase(repository: Resolver.resolve()) as  ArticlesUsecaseProtocol }
    }
}
