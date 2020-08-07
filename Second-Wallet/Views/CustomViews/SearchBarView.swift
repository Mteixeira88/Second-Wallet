import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var onSearching: (Bool) -> Void
    
    @State var isEditing = false
    
    var body: some View {
        HStack {
            Assets.systemIcon(.magnifyGlass)
                .foregroundColor(Assets.colors(.brand))
            TextField("Search", text: $searchText)
                .disableAutocorrection(true)
                .onTapGesture {
                    isEditing = true
                }
                .onChange(of: searchText) { newValue in
                    onSearching(isEditing)
                }
                .cornerRadius(0)
            
                Button("\(Assets.systemIcon(.xmark))", action: {
                    isEditing = false
                    onSearching(isEditing)
                    searchText = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                })
                .padding(.trailing, 10)
                .opacity(isEditing ? 1 : 0)
                .foregroundColor(Assets.colors(.brand))
        }
        .cornerRadius(0)
        .textField(
            error: TextFieldErrorModifierModel(
                showError: .constant(false),
                message: Text("Error search")
            )
        )
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""), onSearching: { status in
            
        })
    }
}
