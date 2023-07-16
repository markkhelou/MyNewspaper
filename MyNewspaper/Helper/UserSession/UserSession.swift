
import SwiftUI

class UserSession: ObservableObject {
    @Published var token: String?
    private var keychain: KeychainProtocol
    
    init(keychain: KeychainProtocol) {
        self.keychain = keychain
        self.token = keychain.getItem(forKey: KeychainKeys.token)
    }
    
    func updateSessionToken(token: String) {
        keychain.storeItem(token, forKey: KeychainKeys.token)
        self.token = token
    }
    
    func invalidateSession() {
        keychain.deleteItem(forKey: KeychainKeys.token)
        self.token = nil
    }
    
    var isValid: Bool {
        token != nil
    }
    
    var getToken: String? {
        token
    }
}
