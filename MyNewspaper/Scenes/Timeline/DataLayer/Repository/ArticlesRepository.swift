
protocol ArticlesRepositoryProtocol {
    func requestArticles() async throws -> [Article]
    func getArticle(id: Int) async throws -> ArticleDetails
}

class ArticlesRepository: ArticlesRepositoryProtocol {
    
    private var remote: ArticlesRemoteProtocol
    
    init(remote: ArticlesRemoteProtocol) {
        self.remote = remote
    }
    
    func requestArticles() async throws -> [Article] {
        try await remote.requestArticles()
    }
    
    func getArticle(id: Int) async throws -> ArticleDetails {
        try await remote.getArticle(id: id)
    }
}
