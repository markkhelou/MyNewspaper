import Foundation

protocol UsersUsecaseProtocol {
    func login(_ request: UserRequest) async throws -> User
    func getUser() async throws -> User
}

class UsersUsecase: UsersUsecaseProtocol {
    
    private var repository: UsersRepositoryProtocol
    
    init(repository: UsersRepositoryProtocol) {
        self.repository = repository
    }
    
    func login(_ request: UserRequest) async throws -> User {
        try await repository.login(request)
    }
    
    func getUser() async throws -> User {
        try await repository.getUser()
    }
}
