
import SwiftUI
import Resolver

@main
struct MyNewspaperApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView(session: UserSession(keychain: Resolver.resolve()))
        }
    }
}
