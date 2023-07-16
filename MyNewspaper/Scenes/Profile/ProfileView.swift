
import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel: ProfileViewModel
    @EnvironmentObject var session: UserSession
    
    var body: some View {
        VStack(alignment: .center) {
            if viewModel.showLoading {
                ProgressView()
            } else if let user = viewModel.user {
                Text(L10n.myProfile).bold().font(.largeTitle).padding()
                profileView(user: user)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
        .alertError(error: $viewModel.error)
        .firstTask {
            await viewModel.getuser()
        }
        .onChange(of: viewModel.isAuthenticated) { newValue in
            if !newValue {
                session.invalidateSession()
            }
        }
        .padding()
    }
    
    private func profileView(user: User) -> some View {
        VStack(alignment: .leading) {
            profileItemView(title: L10n.name, value: user.userFullName)
            profileItemView(title: L10n.email, value: user.email)
            profileItemView(title: L10n.phone, value: user.phone)
            profileItemView(title: L10n.address, value: user.address.fullAddress)
            if !user.activeSubscriptions.isEmpty {
                profileItemView(title: L10n.subscription, value: user.userFullActiveSubscriptions)
            }
        }
    }
    
    private func profileItemView(title: String, value: String) -> some View {
        HStack( alignment: .top, spacing: 5) {
            Text(title).bold()
            Text(value).italic()
        }
    }
}

