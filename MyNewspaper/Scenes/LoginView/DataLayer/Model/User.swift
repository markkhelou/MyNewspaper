
import Foundation

struct UserRequest: Codable {
    let email: String
    let password: String
}

struct User: Codable {
    let userId: Int
    let accessToken: String
    let firstname: String
    let lastname: String
    let phone: String
    let email: String
    let address: Address
    let activeSubscriptions: [Subscription]

    private enum CodingKeys: String, CodingKey {
        case userId, lastname, phone, email
        case accessToken = "access_token"
        case activeSubscriptions = "active_subscriptions"
        case address = "adress"
        case firstname = "fisrtname"
    }
    
    var userFullName: String {
        return "\(firstname) \(lastname)"
    }
    
    var userFullAddress: String {
        return address.fullAddress
    }
    
    var userFullActiveSubscriptions: String {
        return activeSubscriptions.filter({ $0 != .unknown }).map { $0.rawValue }.joined(separator: ", ")
    }
}

enum Subscription: String, Codable {
    case sports
    case full
    case free
    case unknown
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        self = Subscription(rawValue: string) ?? .unknown
    }
}

struct Address: Codable {
    let street: String
    let city: String
    let zip: String
    
    var fullAddress: String {
        return "\(street) \(zip), \(city)"
    }
}
