import SwiftUI

struct TextFieldModifierModel {
    let label: String?
    let bottomLabel: String?
}

struct TextFieldErrorModifierModel {
    @Binding var showError: Bool
    let message: String
}

struct TextFieldModifier: ViewModifier {
    let model: TextFieldModifierModel?
    let error: TextFieldErrorModifierModel
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            if  let model = model,
                let label = model.label {
                Text(label)
                    .font(.body)
            }
            content
                .padding()
                .background(error.showError ? Color(UIColor.red) : Color(UIColor.systemGray6))
                .cornerRadius(8)
            if  let model = model,
                let bottomLabel = model.bottomLabel,
                !error.showError {
                Text(bottomLabel)
                    .font(.caption)
                    .foregroundColor(Color(UIColor.systemGray3))
            }
            if error.showError {
                Text(error.message)
                    .foregroundColor(Color(UIColor.red))
                    .animation(.default)
            }
        }
    }
}
