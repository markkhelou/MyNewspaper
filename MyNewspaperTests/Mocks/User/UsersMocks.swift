
import Foundation
@testable import MyNewspaper

struct UsersMocks {
    static let user: User =
    User(userId: 1, accessToken: "TOKEN", firstname: "My name", lastname: "last name", phone: "332323", email: "test@gmail.com", address: Address(street: "street", city: "Munchen", zip: "80332"), activeSubscriptions: [.sports])
}

