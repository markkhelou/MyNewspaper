
import SwiftUI
import Resolver

struct SplashView: View {
    @StateObject var session: UserSession
    
    var body: some View {
        VStack {
            if session.isValid {
                TabbarView()
            } else {
                LoginView(viewModel: LoginViewModel(usecase: Resolver.resolve()))
            }
        }
        .environmentObject(session)
    }
}
