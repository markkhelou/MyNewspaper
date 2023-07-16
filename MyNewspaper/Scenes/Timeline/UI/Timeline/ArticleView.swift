
import SwiftUI

struct ArticleView: View {
    let article: ArticleTimelineModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            articleItemView(title: L10n.title, value: article.title1)
            articleItemView(title: L10n.description, value: article.title2)
            articleItemView(title: L10n.keyword, value: article.keyword1)
            articleItemView(title: L10n.anotherKeyword, value: article.keyword2)
            Text(article.articleAccess.title).foregroundColor(article.articleAccess.titleColor)
            AsyncImage(url: URL(string: article.imageURL)) { image in image.resizable() } placeholder: { ProgressView() }.frame(width: 75, height: 75)
            Text(article.imageCopyright).font(.caption)
        }
    }
    
    private func articleItemView(title: String, value: String) -> some View {
        HStack(alignment: .top, spacing: 5) {
            Text(title).bold()
            Text(value).foregroundColor(.gray).italic()
        }
    }
}


enum ArticleAccess {
    case free
    case subscripted
    case notSubcripted
    
    var title: String {
        switch self {
        case .free: return L10n.free
        case .subscripted: return L10n.paid
        case .notSubcripted: return L10n.notPaid
        }
    }
    
    var titleColor: Color {
        switch self {
        case .free: return .blue
        case .subscripted: return .green
        case .notSubcripted: return .red
        }
    }
    
    var hasAccess: Bool {
        switch self {
        case .free, .subscripted: return true
        case .notSubcripted: return false
        }
    }
}
