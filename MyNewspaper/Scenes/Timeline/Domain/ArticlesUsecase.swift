
import Foundation

protocol ArticlesUsecaseProtocol {
    func requestArticles() async throws -> [Article]
    func getArticle(id: Int) async throws -> ArticleDetails
}

class ArticlesUsecase: ArticlesUsecaseProtocol {
    
    private var repository: ArticlesRepositoryProtocol
    
    init(repository: ArticlesRepositoryProtocol) {
        self.repository = repository
    }
    
    func requestArticles() async throws -> [Article] {
        try await repository.requestArticles()
    }
    
    func getArticle(id: Int) async throws -> ArticleDetails {
        try await repository.getArticle(id: id)
    }
}
