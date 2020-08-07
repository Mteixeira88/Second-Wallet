import SwiftUI

struct TextFieldModifierModel {
    let label: Text?
    let bottomLabel: String?
}

struct TextFieldErrorModifierModel {
    @Binding var showError: Bool
    let message: Text
}

struct TextFieldModifier: ViewModifier {
    let model: TextFieldModifierModel?
    let error: TextFieldErrorModifierModel
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            if  let model = model,
                let label = model.label {
                label
                    .font(.body)
            }
            content
                .padding()
                .background(error.showError ? Assets.colors(.inputError) : Assets.colors(.inputBackground))
                .cornerRadius(8)
            if  let model = model,
                let bottomLabel = model.bottomLabel,
                !error.showError {
                Text(bottomLabel)
                    .font(.caption)
                    .foregroundColor(Color(UIColor.systemGray3))
            }
            if error.showError {
                error.message
                    .foregroundColor(Assets.colors(.inputErrorLabel))
                    .animation(.default)
            }
        }
    }
}
