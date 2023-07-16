
import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var showLoading: Bool = false
    @Published var isLoginDisabled = true
    @Published var isLoginSucceeded = false
    @Published var error: NetworkError?
    @Published var email: String = "" {
        didSet {
            validateInputs()
        }
    }
    @Published var password: String = "" {
        didSet {
            validateInputs()
        }
    }
    
    private var usecase: UsersUsecaseProtocol
    
    init(usecase: UsersUsecaseProtocol) {
        self.usecase = usecase
    }
    
    @MainActor
    func login() async -> String? {
        self.showLoading = true
        do {
            let request = UserRequest(email: email.lowercased(), password: password)
            let user = try await self.usecase.login(request)
            self.showLoading = false
            self.isLoginSucceeded = true
            return user.accessToken
        } catch let error {
            self.showLoading = false
            self.error = error as? NetworkError
            return nil
        }
    }
    
    private func validateInputs() {
        // In real example we should validate here more, for example email is valid and so on
        // but for this code challenge I keep it simple
        isLoginDisabled = email.isEmpty || password.isEmpty
    }
    
}
