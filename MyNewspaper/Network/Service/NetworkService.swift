import UIKit

public class NetworkService: NetworkServiceProtocol {
    
    private var url: URL?
    private var method: HTTPMethod = .get
    private var body: Data?
    private var queries: [String: String]?
    private var headers: [String: String] = [:]
    private var userSession: UserSession
    
    init(userSession: UserSession) {
        self.userSession = userSession
    }
    
    @discardableResult
    public func withURL(_ url: String) -> Self {
        self.url = URL(string: url)
        return self
    }
    
    @discardableResult
    public func withMethod(_ method: HTTPMethod) -> Self {
        self.method = method
        return self
    }
    
    @discardableResult
    public func withBody<Request: Codable>(_ body: Request) -> Self {
        self.body = try? JSONEncoder().encode(body)
        return self
    }
    
    @discardableResult
    public func withQueries(_ queries: [String: String]) -> Self {
        self.queries = queries
        return self
    }
    
    @discardableResult
    public func withHeaders(_ headers: [String: String]) -> Self {
        self.headers = headers
        return self
    }
    
    func buildURL() throws -> URL {
        guard let url = url else { throw NetworkError.invalidURL }
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        if let queries = queries {
            urlComponents?.queryItems = queries.map({URLQueryItem(name: $0.key, value: $0.value)})
        }
        return urlComponents?.url ?? url
    }
    
    private func buildRequest() throws -> URLRequest {
        var request = URLRequest(url: try buildURL())
        request.httpMethod = self.method.rawValue
        if request.httpMethod != HTTPMethod.get.rawValue {
            request.httpBody = self.body
        }
        if let token = userSession.getToken {
            self.headers["Authorization"] = "Bearer \(token)"
        }
        self.headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = self.headers
        return request
    }
    
    func decode<T: Codable>(_ data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func request<Response: Codable>() async throws -> Response {
        let request = try self.buildRequest()
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidURL
        }
        if (200...299).contains(httpResponse.statusCode) {
            do {
                let body: Response = try self.decode(data)
                return body
            } catch {
                throw NetworkError.decodingFailed
            }
        } else {
            switch httpResponse.statusCode {
            case 401...500: throw NetworkError.authenticationError
            default: throw NetworkError.requestFailed
            }
        }
    }
}
