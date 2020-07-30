import SwiftUI

struct NewCardFormModel {
    var digitsIsEnable: Bool
    var digits: String
    var errorDigits: Bool
    var tag: String
    var errorTag: Bool
    var brand: String
    var errorBrand: Bool
    var secureFields: [SecureFieldsViewModel]
    
}

struct SecureFieldsViewModel {
    var title: String
    var value: String
    var error: Bool
}

struct NewCardFormView: View {
    @State private(set) var newCardForm = NewCardFormModel(
        digitsIsEnable: true,
        digits: "",
        errorDigits: false,
        tag: "",
        errorTag: false,
        brand: "",
        errorBrand: false,
        secureFields: [SecureFieldsViewModel(title: "", value: "", error: false)]
    )
    var baseSecureField = SecureFieldsViewModel(title: "", value: "", error: false)
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var color = Color.white
    
    var body: some View {
        ScrollView() {
            VStack(alignment: .leading) {
                Text("Create card")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
            .padding()
            
            Toggle(isOn: $newCardForm.digitsIsEnable) {
                Text("Four digits")
                    .font(.body)
            }
            .padding(.horizontal)
            
            TextField(
                "eg: Last 4 digits",
                text: $newCardForm.digits,
                onEditingChanged: {_ in
                    self.newCardForm.errorDigits = false
                })
                .disabled(!newCardForm.digitsIsEnable)
                .textField(
                    error: TextFieldErrorModifierModel(showError: $newCardForm.errorDigits, message: "Error")
                )
                .padding(.horizontal)
                .opacity(newCardForm.digitsIsEnable ? 1 : 0.5)
            
            TextField(
                "eg: Mobile, Door duplication card, Debit",
                text: $newCardForm.tag,
                onEditingChanged: { _ in
                    self.newCardForm.errorTag = false
                })
                .textField(
                    model: TextFieldModifierModel(label: "Tag", bottomLabel: "max: 30 chars"),
                    error: TextFieldErrorModifierModel(showError: $newCardForm.errorTag, message: "Error")
                )
                .padding()
            
            TextField(
                "eg: Vodafone, American Express, Dierre",
                text: $newCardForm.brand,
                onEditingChanged: { _ in
                    self.newCardForm.errorBrand = false
                })
                .textField(
                    model: TextFieldModifierModel(label: "Brand", bottomLabel: "max: 20 chars"),
                    error: TextFieldErrorModifierModel(showError: $newCardForm.errorBrand, message: "Error")
                )
                .padding()
            
            VStack(alignment: .leading) {
                Text("Background color")
                    .font(.body)
                ColorPickerView(chosenColor: $color)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                    .rotationEffect(.degrees(-90))
            }
            .padding()
            
            ForEach(0..<newCardForm.secureFields.count, id: \.self) { index in
                VStack(spacing: 0) {
                    TextField(
                        "eg: System Pin, Pin, Puk",
                        text: $newCardForm.secureFields[index].title,
                        onEditingChanged: { _ in
                            self.newCardForm.secureFields[index].error = false
                        })
                        .textField(
                            model: TextFieldModifierModel(label: "#\(index + 1) Secure Field title", bottomLabel: nil),
                            error: TextFieldErrorModifierModel(showError: $newCardForm.secureFields[index].error, message: "Error")
                        )
                        .padding()
                    SecureField("eg: 15121", text:  $newCardForm.secureFields[index].value)
                        .textField(
                            model: TextFieldModifierModel(label: "#\(index + 1) Secure Field value", bottomLabel: nil),
                            error: TextFieldErrorModifierModel(showError: $newCardForm.secureFields[index].error, message: "Error")
                        )
                        .padding(.horizontal)
                }
            }
            
            HStack {
                Spacer()
                Button("\(Image(systemName: "plus")) Add secure field", action: {
                    newCardForm.secureFields.append(baseSecureField)
                })
            }
            .padding()
        }
        
        HStack(spacing: 20) {
            Spacer()
            Button("Cancel", action: {
                presentationMode.wrappedValue.dismiss()
            })
            Button("Confirm", action: {
                newCardForm.errorDigits = true
            })
        }
        .padding()
    }
}

struct NewCardFormView_Previews: PreviewProvider {
    static var previews: some View {
        NewCardFormView()
    }
}
