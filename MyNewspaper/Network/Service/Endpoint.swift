
import Foundation

protocol Endpoint {
    static var baseURL: String { get }
    static func path(_ path: String) -> String
}

extension Endpoint {
    static func configuration(for key: String) -> String { (Bundle.main.object(forInfoDictionaryKey: key) as? String) ?? "" }
    static func path(_ path: String) -> String {  baseURL + path }
}
