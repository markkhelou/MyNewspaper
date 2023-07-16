
@testable import MyNewspaper
import Combine
import XCTest

class MockNetworkService: NetworkServiceProtocol {
    var method: HTTPMethod?
    var url: String?
    var body: Codable?
    var queries: [String: String]?
    var headers: [String: String]?
    var response: Result<Codable, NetworkError>?
    
    @discardableResult
    func withMethod(_ method: HTTPMethod) -> Self {
        self.method = method
        return self
    }
    
    @discardableResult
    func withURL(_ url: String) -> Self {
        self.url = url
        return self
    }
    
    @discardableResult
    func withBody<Request>(_ body: Request) -> Self where Request : Codable {
        self.body = body
        return self
    }
    
    @discardableResult
    func withQueries(_ queries: [String : String]) -> Self {
        self.queries = queries
        return self
    }
    
    @discardableResult
    func withHeaders(_ headers: [String : String]) -> Self {
        self.headers = headers
        return self
    }
    
    var requestResult: Result<Codable, NetworkError>?
    
    func request<Response: Codable>() async throws -> Response {
        guard let result = requestResult else {
            fatalError("MockNetworkService: requestResult not set")
        }
        
        switch result {
        case let .success(response):
            return response as! Response
        case let .failure(error):
            throw error
        }
    }
}
