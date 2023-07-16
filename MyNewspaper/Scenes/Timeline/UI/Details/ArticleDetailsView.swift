import SwiftUI

struct ArticleDetailsView: View {
    
    @StateObject var viewModel: ArticleDetailsViewModel
    @State var showingMoreDetails = false
    
    var body: some View {
        VStack(alignment: .leading) {
            if viewModel.showLoading {
                ProgressView()
            } else if let article = viewModel.articleDetails {
                ScrollView {
                    VStack(alignment: .leading, spacing: 30) {
                        articleImageViewDetails(article: article)
                        articleDetailView(article: article)
                        Button(L10n.moreDetails) {
                            showingMoreDetails.toggle()
                        }
                        .sheet(isPresented: $showingMoreDetails) {
                            SheetView(isPresented: $showingMoreDetails) {
                                Webview(htmlContent: article.contentHTML)
                            }
                        }
                    }
                }
            }
        }
        .padding([.leading, .trailing])
        .alertError(error: $viewModel.error)
        .firstTask {
            await viewModel.requestArticleDetails()
        }
    }
    
    private func articleImageViewDetails(article: ArticleDetails) -> some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: article.imageURL)) { image in image.resizable() } placeholder: { ProgressView() }        .aspectRatio(contentMode: .fill)
            Text(article.imageCaption).font(.caption)
            Text(article.imageCopyright).font(.caption2)
        }
    }
    
    private func articleDetailView(article: ArticleDetails) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            articleItemView(title: L10n.date, value: viewModel.convertDateFormat(dateString: article.datePublished,
                                                                                 newFormat: DateRepresentation.YYYYMMDDHHMMA.rawValue))
            articleItemView(title: L10n.title, value: article.title1)
            articleItemView(title: L10n.description, value: article.title2)
            articleItemView(title: L10n.keyword, value: article.keyword1)
            articleItemView(title: L10n.anotherKeyword, value: article.keyword2)
            articleItemView(title: L10n.subscription, value: article.subscriptionType.rawValue)
        }
    }
    
    private func articleItemView(title: String, value: String) -> some View {
        HStack(alignment: .top, spacing: 5) {
            Text(title).bold()
            Text(value).foregroundColor(.gray).italic()
        }
    }
}
