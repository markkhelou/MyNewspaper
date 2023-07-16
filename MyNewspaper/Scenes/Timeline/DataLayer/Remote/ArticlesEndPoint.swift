
import Foundation

struct ArticlesEndPoint: Endpoint {
    static var baseURL: String = configuration(for: "BASE_URL")
    
    static var articles: String {
        return "\(baseURL)/articles"
    }
    
    static func getArticle(id: Int) -> String {
        return "\(baseURL)/articles/\(id)"
    }
}
