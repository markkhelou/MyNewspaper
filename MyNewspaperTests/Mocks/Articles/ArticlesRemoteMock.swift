
@testable import MyNewspaper
import Combine
import XCTest

class ArticlesRemoteMock: ArticlesRemoteProtocol {
    var requestResult: Result<Codable, NetworkError>?
    
    private var mockNetworkService = MockNetworkService()

    func requestArticles() async throws -> [Article] {
        mockNetworkService.requestResult = requestResult
        return try await mockNetworkService.request()
    }
    
    func getArticle(id: Int) async throws -> ArticleDetails {
        mockNetworkService.requestResult = requestResult
        return try await mockNetworkService.request()
    }
}
