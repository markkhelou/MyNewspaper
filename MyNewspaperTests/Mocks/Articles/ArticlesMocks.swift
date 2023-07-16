
import Foundation
@testable import MyNewspaper

struct ArticlesMocks {
    static let articles: [Article] = [
        Article(id: 1, keyword1: "Sports", authorName: "John Doe", keyword2: "Football", imageURL: "https://example.com/image1.jpg", title1: "Article 1", title2: "The First Article", imageCopyright: "Copyright", subscriptionType: .free),
        Article(id: 2, keyword1: "Sports", authorName: "John Doe", keyword2: "Football", imageURL: "https://example.com/image1.jpg", title1: "Article 1", title2: "The First Article", imageCopyright: "Copyright", subscriptionType: .sports),
        Article(id: 3, keyword1: "Sports", authorName: "John Doe", keyword2: "Football", imageURL: "https://example.com/image1.jpg", title1: "Article 1", title2: "The First Article", imageCopyright: "Copyright", subscriptionType: .full)
    ]
    
    static let articleDetails: ArticleDetails = ArticleDetails(id: 3, datePublished: "2023-07-15", imageCaption: "Article Image", keyword1: "Sports", authorName: "John Doe", keyword2: "Football", imageURL: "https://example.com/image1.jpg", title1: "Article 1", title2: "The First Article", imageCopyright: "Copyright", contentHTML: "<p>Lorem ipsum</p>", subscriptionType: .free)
}
