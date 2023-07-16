
import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var error: NetworkError?
    @Published var showLoading: Bool = false
    @Published var isAuthenticated: Bool = true
    @Published var user: User?
    
    private let usecase: UsersUsecaseProtocol
    
    init(usecase: UsersUsecaseProtocol) {
        self.usecase = usecase
    }
    
    @MainActor
    func getuser() async {
        self.showLoading = true
        do {
            let userResult = try await self.usecase.getUser()
            self.showLoading = false
            self.user = userResult
        } catch let error {
            self.showLoading = false
            if let networkError = error as? NetworkError, networkError == .authenticationError {
                self.isAuthenticated = false
                return
            }
            self.error = error as? NetworkError
        }
    }
}
