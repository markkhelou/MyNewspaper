
import Foundation

struct UsersEndPoint: Endpoint {
    static var baseURL: String = configuration(for: "BASE_URL")
    
    static var login: String {
        return "\(baseURL)/users/login"
    }
    
    static var getUser: String {
        return "\(baseURL)/users/me"
    }
}

