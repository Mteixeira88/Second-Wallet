import SwiftUI

struct NewCardFormView: View {
    @ObservedObject var viewModel: NewCardViewModel
    
    var body: some View {
        ScrollView() {
            HStack() {
                Text("\(Assets.systemIcon(.info)) General Info")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Assets.colors(.brand))
                Spacer()
            }
            .padding()
            
            centerView
            
            Divider()
            
            HStack() {
                Text("\(Assets.systemIcon(.locker)) Card's safe")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Assets.colors(.brand))
                Spacer()
                Button(action: {
                    viewModel.addSecureField()
                }) {
                    Text("\(Assets.systemIcon(.plus)) Add secure field")
                        .font(.subheadline)
                }
            }
            .padding(.horizontal)
            .padding(.top)
        }
    }
}

struct NewCardFormView_Previews: PreviewProvider {
    static var previews: some View {
        NewCardFormView(viewModel: NewCardViewModel())
    }
}

extension NewCardFormView {
    
    var centerView: some View {
        VStack(spacing: 25) {
            VStack(spacing: 5) {
                Toggle(isOn: $viewModel.formModel.digitsIsEnable) {
                    Text("Four digits")
                        .font(.body)
                }
                
                TextField(
                    "eg: Last 4 digits",
                    text: $viewModel.formModel.digits
                )
                .disableAutocorrection(true)
                .disabled(!viewModel.formModel.digitsIsEnable)
                .textField(
                    error: TextFieldErrorModifierModel(
                        showError: $viewModel.formModel.errorDigits,
                        message: Text("Error digits")
                    )
                )
                .opacity(viewModel.formModel.digitsIsEnable ? 1 : 0.5)
                .onChange(of: viewModel.formModel.digits) { newValue in
                    viewModel.formModel.errorDigits = false
                }
                
            }
            
            TextField(
                "eg: Mobile, Door duplication card, Debit",
                text: $viewModel.formModel.tag
            )
            .textField(
                model: TextFieldModifierModel(
                    label: Text("Tag"),
                    bottomLabel: "max: 30 chars"
                ),
                error: TextFieldErrorModifierModel(
                    showError: $viewModel.formModel.errorTag,
                    message: Text("Error tag")
                )
            )
            .disableAutocorrection(true)
            .onChange(of: viewModel.formModel.tag) { newValue in
                viewModel.formModel.errorTag = false
            }
            
            TextField(
                "eg: Vodafone, American Express, Dierre",
                text: $viewModel.formModel.brand
            )
            .textField(
                model: TextFieldModifierModel(
                    label: Text("Brand"),
                    bottomLabel: "max: 20 chars"
                ),
                error: TextFieldErrorModifierModel(
                    showError: $viewModel.formModel.errorBrand,
                    message: Text("Error brand")
                )
            )
            .disableAutocorrection(true)
            .onChange(of: viewModel.formModel.brand) { newValue in
                viewModel.formModel.errorBrand = false
            }
            
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
        }
        .padding()
    }
}
