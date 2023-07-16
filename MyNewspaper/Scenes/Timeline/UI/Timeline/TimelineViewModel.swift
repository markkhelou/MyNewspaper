
import Foundation

class TimelineViewModel: ObservableObject {
    
    @Published var error: NetworkError?
    @Published var showLoading: Bool = false
    @Published var isAuthenticated: Bool = true
    @Published var articles: [ArticleTimelineModel] = []
    
    private let usecase: ArticlesUsecaseProtocol
    private let userUsecase: UsersUsecaseProtocol
    
    init(usecase: ArticlesUsecaseProtocol, userUsecase: UsersUsecaseProtocol) {
        self.usecase = usecase
        self.userUsecase = userUsecase
    }
    
    func retryPressed() {
        Task {
            await requestArticles(showLoading: false)
        }
    }
    
    @MainActor
    func requestArticles(showLoading: Bool = true) async {
        self.showLoading = showLoading
        do {
            async let articlesResult = try self.usecase.requestArticles()
            async let userResult = try self.userUsecase.getUser()
            
            let articlesResultValue = try await articlesResult
            let userResultValue = try await userResult
            self.showLoading = false
            self.articles = mapToArticleUIModel(articlesResultValue, subscriptions: userResultValue.activeSubscriptions)
        } catch let error {
            self.showLoading = false
            if let networkError = error as? NetworkError, networkError == .authenticationError {
                self.isAuthenticated = false
                return
            }
            self.error = error as? NetworkError
        }
    }
    
    func getArticleAcess(subscriptionType: Subscription , userSubscriptions: [Subscription]) -> ArticleAccess {
        guard subscriptionType != .unknown else { return .notSubcripted }
        if subscriptionType == .free {
            return .free
        }
        if userSubscriptions.contains(where: { $0 == subscriptionType}) {
            return .subscripted
        }
        return .notSubcripted
    }
    
    private func mapToArticleUIModel(_ response: [Article], subscriptions: [Subscription]) -> [ArticleTimelineModel] {
        response.map { article in
            ArticleTimelineModel(id: article.id, title1: article.title1, title2: article.title2, keyword1: article.keyword1,
                                 keyword2: article.keyword2, authorName: article.authorName, imageURL: article.imageURL,
                                 imageCopyright: article.imageCopyright,
                                 articleAccess: getArticleAcess(subscriptionType: article.subscriptionType,
                                                                userSubscriptions: subscriptions))
            
        }
    }
}
