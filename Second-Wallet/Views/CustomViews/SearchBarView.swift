import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var onSearching: (Bool) -> Void
    
    @State var isEditing = false
    
    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
                .disableAutocorrection(true)
                .textField(
                    error: TextFieldErrorModifierModel(
                        showError: .constant(false),
                        message: "Error"
                    )
                )
                .onTapGesture {
                    isEditing = true
                }
                .onChange(of: searchText) { newValue in
                    onSearching(isEditing)
                }
            
            if isEditing {
                Button("Cancel", action: {
                    isEditing = false
                    searchText = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                })
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""), onSearching: { status in
            
        })
    }
}
