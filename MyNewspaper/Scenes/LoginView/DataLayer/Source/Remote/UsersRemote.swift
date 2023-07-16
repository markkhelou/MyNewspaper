import Foundation

protocol UsersRemoteProtocol {
    func login(_ request: UserRequest) async throws -> User
    func getUser() async throws -> User
}

class UsersRemote: UsersRemoteProtocol {
    
    private var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func login(_ request: UserRequest) async throws -> User {
        try await networkService
            .withURL(UsersEndPoint.login)
            .withMethod(.post)
            .withBody(request)
            .request()
    }
    
    func getUser() async throws -> User {
        try await networkService
            .withURL(UsersEndPoint.getUser)
            .request()
    }
}
