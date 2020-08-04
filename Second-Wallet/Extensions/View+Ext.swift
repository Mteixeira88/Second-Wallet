import SwiftUI

extension View {
    func textField(
        model: TextFieldModifierModel? = nil,
        error: TextFieldErrorModifierModel
    ) -> some View {
        self.modifier(TextFieldModifier(model: model, error: error))
    }
    
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
    
    func resignKeyboardOnTapGesture() -> some View {
        return modifier(ResignKeyboardOnTapGesture())
    }
}
