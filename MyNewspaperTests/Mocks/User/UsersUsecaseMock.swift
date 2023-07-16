
@testable import MyNewspaper
import Combine
import XCTest

class UsersUsecaseMock: UsersUsecaseProtocol {

    var requestResult: Result<Codable, NetworkError>?
    
    private var mockRepository = UsersRepositoryMock()
    
    func login(_ request: UserRequest) async throws -> User {
        mockRepository.requestResult = requestResult
        return try await mockRepository.login(request)
    }
    
    func getUser() async throws -> User {
        mockRepository.requestResult = requestResult
        return try await mockRepository.getUser()
    }
}
