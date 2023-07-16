
import Foundation

struct Article: Codable {
    let id: Int
    let keyword1: String
    let authorName: String
    let keyword2: String
    let imageURL: String
    let title1: String
    let title2: String
    let imageCopyright: String
    let subscriptionType: Subscription
}

enum ArticleSubscriptionType: String, Codable {
    case sports
    case full
    case free
    case unknown
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        self = ArticleSubscriptionType(rawValue: string) ?? .unknown
    }
}

struct ArticleDetails: Codable {
    let id: Int
    let datePublished: String
    let imageCaption: String
    let keyword1: String
    let authorName: String
    let keyword2: String
    let imageURL: String
    let title1: String
    let title2: String
    let imageCopyright: String
    let contentHTML: String
    let subscriptionType: Subscription
}

struct ArticleTimelineModel: Hashable {
    var id: Int
    var title1: String
    var title2: String
    var keyword1: String
    var keyword2: String
    var authorName: String
    var imageURL: String
    var imageCopyright: String
    var articleAccess: ArticleAccess
}
