
@testable import MyNewspaper
import Combine
import XCTest

class ArticlesRepositoryMock: ArticlesRepositoryProtocol {
    var requestResult: Result<Codable, NetworkError>?
    
    private var mockRemote = ArticlesRemoteMock()

    func requestArticles() async throws -> [Article] {
        mockRemote.requestResult = requestResult
        return try await mockRemote.requestArticles()
    }
    
    func getArticle(id: Int) async throws -> ArticleDetails {
        mockRemote.requestResult = requestResult
        return try await mockRemote.getArticle(id: id)
    }
}
