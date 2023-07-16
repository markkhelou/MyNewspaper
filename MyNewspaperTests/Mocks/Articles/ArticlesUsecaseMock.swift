
@testable import MyNewspaper
import Combine
import XCTest

class ArticlesUsecaseMock: ArticlesUsecaseProtocol {
    var requestResult: Result<Codable, NetworkError>?
    
    private var mockRepository = ArticlesRepositoryMock()

    func requestArticles() async throws -> [Article] {
        mockRepository.requestResult = requestResult
        return try await mockRepository.requestArticles()
    }
    
    func getArticle(id: Int) async throws -> ArticleDetails {
        mockRepository.requestResult = requestResult
        return try await mockRepository.getArticle(id: id)
    }
}
