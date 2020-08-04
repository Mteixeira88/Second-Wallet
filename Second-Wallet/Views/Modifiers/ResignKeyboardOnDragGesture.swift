import SwiftUI

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged { _ in
        UIApplication.shared.endEditing(true)
    }
    
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

struct ResignKeyboardOnTapGesture: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture(count: 1, perform: {
                UIApplication.shared.endEditing(true)
            })
    }
}
