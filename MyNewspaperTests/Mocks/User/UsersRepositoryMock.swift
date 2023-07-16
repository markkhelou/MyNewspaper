
@testable import MyNewspaper
import Combine
import XCTest

class UsersRepositoryMock: UsersRepositoryProtocol {

    var requestResult: Result<Codable, NetworkError>?
    
    private var mockRemote = UsersRemoteMock()
    
    func login(_ request: UserRequest) async throws -> User {
        mockRemote.requestResult = requestResult
        return try await mockRemote.login(request)
    }
    
    func getUser() async throws -> User {
        mockRemote.requestResult = requestResult
        return try await mockRemote.getUser()
    }
}
