import SwiftUI

struct AddNewCard: View {
    @State var showNewCard = false
    @StateObject var newCardViewModel = NewCardViewModel()
    
    var viewModel: CardsListViewModel
    
    var body: some View {
        VStack {
            Button("\(Image(systemName: "plus")) Add new card", action: {
                newCardViewModel.resetForm()
                showNewCard.toggle()
            })
        }
        .sheet(isPresented: $showNewCard, content: {
            VStack {
                NewCardFormView(viewModel: newCardViewModel)
                HStack(spacing: 20) {
                    Spacer()
                    Button("Cancel", action: {
                        showNewCard.toggle()
                    })
                    Button("Confirm", action: {
                        if !newCardViewModel.validateForm() {
                            return
                        }
                        viewModel.createNew(card: newCardViewModel.createCard(), secureFields: newCardViewModel.createSecureFieds())
                        showNewCard.toggle()
                    })
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
