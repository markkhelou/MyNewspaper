
import Foundation
import Resolver

class DILoginRegister {
    
    static func register() {
        Resolver.register { UsersRemote(networkService: Resolver.resolve()) as UsersRemoteProtocol }
        Resolver.register { UsersRepository(remote: Resolver.resolve()) as UsersRepositoryProtocol }
        Resolver.register { UsersUsecase(repository: Resolver.resolve()) as UsersUsecaseProtocol }
    }
}
