import SwiftUI
import Introspect

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
                text: $viewModel.formModel.digits
            )
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
                text: $viewModel.formModel.tag
            )
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
                text: $viewModel.formModel.brand
            )
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
            
            VStack(alignment: .leading) {
                Text("Background color")
                    .font(.body)
                ColorPicker(
                    selection: $viewModel.formModel.backgroundColor,
                    supportsOpacity: false,
                    label: {
                        Rectangle()
                            .fill(viewModel.formModel.backgroundColor)
                    }
                )
            }
            .padding()
            
            Divider()
            
            HStack {
                Spacer()
                Button("\(Image(systemName: "plus")) Add secure field", action: {
                    viewModel.addSecureField()
                })
            }
            .padding(.top, 10)
            .padding(.horizontal, 16)
            
            List {
                ForEach(0..<viewModel.formModel.secureFields.count, id: \.self) { index in
                    VStack(spacing: 0) {
                        if viewModel.formModel.secureFields.count > 1 {
                            HStack {
                                Spacer()
                                Button("\(Image(systemName: "minus")) Remove field", action: {
                                    viewModel.removeSecureField(at: index)
                                })
                                .font(.caption)
                                .foregroundColor(.red)
                            }
                        }
                        TextField(
                            "eg: System Pin, Pin, Puk",
                            text: $viewModel.formModel.secureFields[index].title)
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
                        SecureField(
                            "eg: 15121",
                            text:  $viewModel.formModel.secureFields[index].value
                        )
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
                        .padding(.bottom, 10)
                        .onChange(of: viewModel.formModel.secureFields[index].value) { newValue in
                            viewModel.formModel.secureFields[index].error = false
                        }
                    }
                }
            }
            .frame(height: CGFloat(250 * viewModel.formModel.secureFields.count))
            .introspectTableView { tableView in
                tableView.isScrollEnabled = false
            }
        }
    }
}

struct NewCardFormView_Previews: PreviewProvider {
    static var previews: some View {
        NewCardFormView(viewModel: NewCardViewModel())
    }
}
