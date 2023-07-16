import SwiftUI

extension View {
    func alertError(error: Binding<NetworkError?>) -> some View {
        let isShowingError = Binding(
            get: { error.wrappedValue != nil },
            set: { value in
                if !value {
                    error.wrappedValue = nil
                }
            }
        )
        return self.alert(isPresented: isShowingError) {
            Alert(title: Text(L10n.error), message: Text(error.wrappedValue?.localizedDescription ?? ""),
                  dismissButton: .default(Text(L10n.dismiss)))
        }
    }
    
    func firstTask(perform action: @escaping (() async -> Void)) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }
}

struct ViewDidLoadModifier: ViewModifier {
    
    @State private var wasCalled = false
    private let action: (() async -> Void)
    
    init(perform action: @escaping (() async -> Void)) {
        self.action = action
    }
    
    func body(content: Content) -> some View {
        content.task {
            if !wasCalled {
                wasCalled = true
                await action()
            }
        }
    }
}
