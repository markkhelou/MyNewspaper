import KeychainSwift

protocol KeychainProtocol {
    func storeItem(_ value: String, forKey key: String)
    func getItem(forKey key: String) -> String?
    func deleteItem(forKey key: String)
}

class KeychainService: KeychainProtocol {
    private let keychain = KeychainSwift()
    
    // MARK: - Storing Items
    func storeItem(_ value: String, forKey key: String) {
        keychain.set(value, forKey: key)
    }
    
    // MARK: - Retrieving Items
    func getItem(forKey key: String) -> String? {
        keychain.get(key)
    }
    
    // MARK: - clear Items
    func deleteItem(forKey key: String) {
        keychain.delete(key)
    }
}
