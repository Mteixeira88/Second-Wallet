import SwiftUI

struct AddNewCard: View {
    @State var showNewCard = false
    @StateObject var newCardViewModel = NewCardViewModel()
    
    var viewModel: CardsListViewModel
    
    var body: some View {
        VStack {
            Button(action: {
                newCardViewModel.resetForm()
                showNewCard.toggle()
            }) {
                Text("\(Assets.systemIcon(.plus)) Add new card")
            }
            .foregroundColor(Assets.colors(.brand))
        }
        .sheet(isPresented: $showNewCard, content: {
            VStack {
                NewCardFormView(viewModel: newCardViewModel)
                HStack(spacing: 20) {
                    Spacer()
                    Button(action: {
                        showNewCard.toggle()
                    }) {
                        Text("Cancel")
                    }
                    Button(action: {
                        if !newCardViewModel.validateForm() {
                            return
                        }
                        viewModel.createNew(
                            card: newCardViewModel.createCard(),
                            secureFields: newCardViewModel.createSecureFieds()
                        )
                        showNewCard.toggle()
                    }) {
                        Text("Confirm")
                    }
                }
                .padding()
            }
        })
    }
}

struct AddNewCard_Previews: PreviewProvider {
    static var previews: some View {
        AddNewCard(viewModel: testViewModel)
    }
}
