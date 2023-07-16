
import Foundation

protocol UsersRepositoryProtocol {
    func login(_ request: UserRequest) async throws -> User
    func getUser() async throws -> User
}

class UsersRepository: UsersRepositoryProtocol {
    
    private var remote: UsersRemoteProtocol
    
    init(remote: UsersRemoteProtocol) {
        self.remote = remote
    }
    
    func login(_ request: UserRequest) async throws -> User {
        try await remote.login(request)
    }
    
    func getUser() async throws -> User {
        try await remote.getUser()
    }
}
