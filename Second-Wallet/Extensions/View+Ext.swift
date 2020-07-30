import SwiftUI

extension View {
    func textField(model: TextFieldModifierModel? = nil, error: TextFieldErrorModifierModel) -> some View {
        self.modifier(TextFieldModifier(model: model, error: error))
    }
}
