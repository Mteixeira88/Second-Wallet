import SwiftUI

struct NewCardFormView: View {
    @ObservedObject var viewModel: NewCardViewModel
    
    var body: some View {
        ScrollView() {
            VStack(alignment: .leading) {
                Text("Create card")
                    .font(.title)
                    .fontWeight(.semibold)
            }
            .padding()
            
            Toggle(isOn: $viewModel.formModel.digitsIsEnable) {
                Text("Four digits")
                    .font(.body)
            }
            .padding(.horizontal)
            
            TextField(
                "eg: Last 4 digits",
                text: $viewModel.formModel.digits,
                onEditingChanged: { changed in
                    self.viewModel.formModel.errorDigits = false
                })
                .disabled(!viewModel.formModel.digitsIsEnable)
                .textField(
                    error: TextFieldErrorModifierModel(showError: $viewModel.formModel.errorDigits, message: "Error")
                )
                .padding(.horizontal)
                .opacity(viewModel.formModel.digitsIsEnable ? 1 : 0.5)
            
            TextField(
                "eg: Mobile, Door duplication card, Debit",
                text: $viewModel.formModel.tag,
                onEditingChanged: { _ in
                    self.viewModel.formModel.errorTag = false
                })
                .textField(
                    model: TextFieldModifierModel(
                        label: "Tag",
                        bottomLabel: "max: 30 chars"
                    ),
                    error: TextFieldErrorModifierModel(
                        showError: $viewModel.formModel.errorTag,
                        message: "Error"
                    )
                )
                .padding()
            
            TextField(
                "eg: Vodafone, American Express, Dierre",
                text: $viewModel.formModel.brand,
                onEditingChanged: { _ in
                    self.viewModel.formModel.errorBrand = false
                })
                .textField(
                    model: TextFieldModifierModel(
                        label: "Brand",
                        bottomLabel: "max: 20 chars"
                    ),
                    error: TextFieldErrorModifierModel(
                        showError: $viewModel.formModel.errorBrand,
                        message: "Error"
                    )
                )
                .padding()
            
            HStack() {
                VStack(alignment: .leading) {
                    Text("Background color")
                        .font(.body)
                    ColorPickerView(chosenColor: $viewModel.formModel.backgroundColor)
                        .frame(minWidth: 0, maxWidth: 200, minHeight: 0, maxHeight: 50)
                        .rotationEffect(.degrees(-90))
                }
                Spacer()
            }
            .padding()
            
            ForEach(0..<viewModel.formModel.secureFields.count, id: \.self) { index in
                VStack(spacing: 0) {
                    TextField(
                        "eg: System Pin, Pin, Puk",
                        text: $viewModel.formModel.secureFields[index].title,
                        onEditingChanged: { _ in
                            self.viewModel.formModel.secureFields[index].error = false
                        })
                        .textField(
                            model: TextFieldModifierModel(
                                label: "#\(index + 1) Secure Field title",
                                bottomLabel: nil
                            ),
                            error: TextFieldErrorModifierModel(
                                showError: $viewModel.formModel.secureFields[index].error,
                                message: "Error"
                            )
                        )
                        .padding()
                    SecureField("eg: 15121", text:  $viewModel.formModel.secureFields[index].value)
                        .textField(
                            model: TextFieldModifierModel(
                                label: "#\(index + 1) Secure Field value",
                                bottomLabel: nil
                            ),
                            error: TextFieldErrorModifierModel(
                                showError: $viewModel.formModel.secureFields[index].error,
                                message: "Error"
                            )
                        )
                        .padding(.horizontal)
                }
            }
            
            HStack {
                Spacer()
                Button("\(Image(systemName: "plus")) Add secure field", action: {
                    viewModel.formModel.secureFields.append(SecureFieldsViewModel())
                })
            }
            .padding()
        }
    }
}

struct NewCardFormView_Previews: PreviewProvider {
    static var previews: some View {
        NewCardFormView(viewModel: NewCardViewModel())
    }
}
