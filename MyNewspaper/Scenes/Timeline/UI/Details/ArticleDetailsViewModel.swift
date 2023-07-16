
import Foundation

class ArticleDetailsViewModel: ObservableObject {
    
    @Published var error: NetworkError?
    @Published var showLoading: Bool = false
    @Published var articleDetails: ArticleDetails?
    
    private let usecase: ArticlesUsecaseProtocol
    private let articleId: Int
    
    init(usecase: ArticlesUsecaseProtocol, articleId: Int) {
        self.usecase = usecase
        self.articleId = articleId
    }
    
    @MainActor
    func requestArticleDetails() async {
        self.showLoading = true
        do {
            let articleDetailResult = try await self.usecase.getArticle(id: articleId)
            self.showLoading = false
            self.articleDetails = articleDetailResult
        } catch let error {
            self.showLoading = false
            self.error = error as? NetworkError
        }
    }
    
    func convertDateFormat(dateString: String, newFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateRepresentation.YYYYMMDDHHMMSS.rawValue
        
        let date = dateFormatter.date(from: dateString) ?? Date()
        dateFormatter.dateFormat = newFormat
        let newDateString = dateFormatter.string(from: date)
        return newDateString
    }
}
