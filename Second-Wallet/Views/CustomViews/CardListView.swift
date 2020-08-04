import SwiftUI

struct CardListView: View {
    private(set) var adaptiveLayout = [GridItem(.adaptive(minimum: 300))]
    var viewModel: CardsListViewModel
    
    @State var editMode = false
    @State var editCardModel = NewCardViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            Text("Tap card for details")
                .font(.body)
                .foregroundColor(Color(UIColor.systemGray2))
            LazyVGrid(columns: adaptiveLayout, spacing: 20) {
                ForEach(viewModel.cards) { card in
                    CardView(viewModel: CardViewModel(card: card)) { actions in
                        switch actions {
                        case .delete:
                            viewModel.deleteCard(card)
                        case .edit:
                            editCardModel.editCard(card: card)
                            editMode.toggle()
                        }
                    }
                }
                .transition(.move(edge: .top))
                .animation(.default)
            }
        }
        .resignKeyboardOnDragGesture()
        .padding(.top, 10)
        .sheet(isPresented: $editMode, content: {
            VStack {
                NewCardFormView(viewModel: editCardModel)
                HStack(spacing: 20) {
                    Spacer()
                    Button("Cancel", action: {
                        editMode.toggle()
                    })
                    Button("Confirm", action: {
//                        if !viewModel.validateForm() {
//                            return
//                        }
//                        viewModel.createNew(
//                            card: newCardViewModel.createCard(),
//                            secureFields: newCardViewModel.createSecureFieds()
//                        )
                        editMode.toggle()
                    })
                }
                .padding()
            }
        })
       
    }
}

struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        CardListView(viewModel: testViewModel)
    }
}
