
import Foundation

protocol NetworkServiceProtocol {
    @discardableResult func withMethod(_ method: HTTPMethod) -> Self
    @discardableResult func withURL(_ url: String) -> Self
    @discardableResult func withBody<Request: Codable>(_ body: Request) -> Self
    @discardableResult func withQueries(_ queries: [String: String]) -> Self
    @discardableResult func withHeaders(_ headers: [String: String]) -> Self
    
    func request<Response: Codable>() async throws -> Response
}
