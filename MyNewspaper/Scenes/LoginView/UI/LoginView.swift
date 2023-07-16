
import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel: LoginViewModel
    @EnvironmentObject var session: UserSession
    
    var body: some View {
        VStack(spacing: 20) {
            Text(L10n.login)
                .font(.largeTitle)
                .padding()
            
            Image(uiImage: Asset.Login.profile.image).resizable().frame(width: 150, height: 150)
            
            TextField(L10n.email, text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField(L10n.password, text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Spacer()
            
            ZStack {
                Button(action: {
                    Task {
                        if let token = await viewModel.login() {
                            session.updateSessionToken(token: token)
                        }
                    }
                }) {
                    Text(viewModel.showLoading ? "" : L10n.login)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .opacity(viewModel.isLoginDisabled ? 0.5 : 1)
                .disabled(viewModel.isLoginDisabled || viewModel.showLoading)
                if viewModel.showLoading {
                    ProgressView()
                }
            }
        }
        .alertError(error: $viewModel.error)
        .padding()
    }
    
}
