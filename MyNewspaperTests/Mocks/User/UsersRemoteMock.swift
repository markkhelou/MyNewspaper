
@testable import MyNewspaper
import Combine
import XCTest

class UsersRemoteMock: UsersRemoteProtocol {

    var requestResult: Result<Codable, NetworkError>?
    
    private var mockNetworkService = MockNetworkService()

    func login(_ request: MyNewspaper.UserRequest) async throws -> MyNewspaper.User {
        mockNetworkService.requestResult = requestResult
        return try await mockNetworkService.request()
    }
    
    func getUser() async throws -> MyNewspaper.User {
        mockNetworkService.requestResult = requestResult
        return try await mockNetworkService.request()
    }
}
