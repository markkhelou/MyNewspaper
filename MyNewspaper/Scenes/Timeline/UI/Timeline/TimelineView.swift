
import SwiftUI
import Resolver

struct TimelineView: View {
    
    @StateObject var viewModel: TimelineViewModel
    @EnvironmentObject var session: UserSession

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.showLoading {
                     ProgressView()
                } else {
                    VStack {
                      articleListView
                    }
                }
            }
            .alertError(error: $viewModel.error)
            .navigationTitle(L10n.timeline)
            .firstTask {
                await viewModel.requestArticles()
            }
            .onChange(of: viewModel.isAuthenticated) { newValue in
                if !newValue {
                    session.invalidateSession()
                }
            }
        }
    }
    
    private var articleListView: some View {
        List(viewModel.articles, id: \.self) { article in
            if article.articleAccess.hasAccess {
                NavigationLink(destination: ArticleDetailsView(viewModel: ArticleDetailsViewModel(usecase: Resolver.resolve(), articleId: article.id))) {
                    ArticleView(article: article)
                }
            } else {
                ArticleView(article: article)
            }
        }
        .refreshable {
            viewModel.retryPressed()
        }
    }
}
