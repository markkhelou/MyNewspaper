
import Foundation

protocol ArticlesRemoteProtocol {
    func requestArticles() async throws -> [Article]
    func getArticle(id: Int) async throws -> ArticleDetails
}

class ArticlesRemote: ArticlesRemoteProtocol {
    
    private var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func requestArticles() async throws -> [Article] {
        try await networkService
            .withURL(ArticlesEndPoint.articles)
            .request()
    }
    
    func getArticle(id: Int) async throws -> ArticleDetails {
        try await networkService
            .withURL(ArticlesEndPoint.getArticle(id: id))
            .request()
    }
}
