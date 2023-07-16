
import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case invalidData
    case authenticationError
    case decodingFailed
    
    var localizedDescription: String {
        switch self {
        case .invalidURL: return L10n.errorInvalidURL
        case .requestFailed: return L10n.errorRequestFailed
        case .invalidResponse: return L10n.errorInvalidResponse
        case .invalidData: return L10n.errorInvalidData
        case .authenticationError: return L10n.errorAuthenticationError
        case .decodingFailed: return L10n.errorDecodingFailed
        }
    }
}
