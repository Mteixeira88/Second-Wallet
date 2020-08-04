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
                    viewModel.formModel.errorDigits = false
                })
                .disableAutocorrection(true)
                .disabled(!viewModel.formModel.digitsIsEnable)
                .textField(
                    error: TextFieldErrorModifierModel(
                        showError: $viewModel.formModel.errorDigits,
                        message: "Error"
                    )
                )
                .padding(.horizontal)
                .opacity(viewModel.formModel.digitsIsEnable ? 1 : 0.5)
                .onChange(of: viewModel.formModel.digits) { newValue in
                    viewModel.formModel.errorDigits = false
                }
            
            TextField(
                "eg: Mobile, Door duplication card, Debit",
                text: $viewModel.formModel.tag,
                onEditingChanged: { _ in
                    viewModel.formModel.errorTag = false
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
                .disableAutocorrection(true)
                .onChange(of: viewModel.formModel.tag) { newValue in
                    viewModel.formModel.errorTag = false
                }
                .padding()
            
            TextField(
                "eg: Vodafone, American Express, Dierre",
                text: $viewModel.formModel.brand,
                onEditingChanged: { _ in
                    viewModel.formModel.errorBrand = false
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
                .disableAutocorrection(true)
                .onChange(of: viewModel.formModel.brand) { newValue in
                    viewModel.formModel.errorBrand = false
                }
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
                    Divider()
                    if index > 0 {
                        HStack {
                            Spacer()
                            Button("\(Image(systemName: "minus")) Remove field", action: {
                                viewModel.formModel.secureFields.remove(at: index)
                            })
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(.top, 10)
                            .padding(.horizontal, 16)
                        }
                    }
                    TextField(
                        "eg: System Pin, Pin, Puk",
                        text: $viewModel.formModel.secureFields[index].title,
                        onEditingChanged: { _ in
                            viewModel.formModel.secureFields[index].error = false
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
                        .onChange(of: viewModel.formModel.secureFields[index].title) { newValue in
                            viewModel.formModel.secureFields[index].error = false
                        }
                        .disableAutocorrection(true)
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
                        .disableAutocorrection(true)
                        .padding(.horizontal)
                        .onChange(of: viewModel.formModel.secureFields[index].value) { newValue in
                            viewModel.formModel.secureFields[index].error = false
                        }
                    Divider()
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
