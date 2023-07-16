
import SwiftUI
import Resolver

struct TabbarView: View {
        
    var body: some View {
        TabView() {
            TimelineView(viewModel: TimelineViewModel(usecase: Resolver.resolve(), userUsecase: Resolver.resolve()))
                .tabItem {
                    Label(L10n.timeline, image: Asset.Tabbar.home.name)
                }

            ProfileView(viewModel: ProfileViewModel(usecase: Resolver.resolve()))
                .tabItem {
                    Label(L10n.myProfile, image: Asset.Tabbar.profile.name)
                }
        }
    }
}
