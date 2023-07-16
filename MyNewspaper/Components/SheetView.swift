
import SwiftUI

struct SheetView<Content: View>: View {
    @Binding private var isPresented: Bool
    private let content: Content
    
    init(isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._isPresented = isPresented
        self.content = content()
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    isPresented = false
                }) {
                    Image(systemName: "xmark")
                        .font(.title)
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            .background(Color(UIColor.systemBackground))
            
            content
        }
    }
}
