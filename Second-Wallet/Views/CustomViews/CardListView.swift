import SwiftUI

struct CardListView: View {
    private(set) var adaptiveLayout = [GridItem(.adaptive(minimum: 300))]
    var viewModel: CardsListViewModel
    
    @State var editMode = false
    @State var editCardFormModel = NewCardViewModel()
    @State var editCardModel = CardModel(tag: "", brand: "", backgroundColor: "")
    
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
                            editCardModel = card
                            editCardFormModel.editCard(card: card)
                            editMode.toggle()
                        }
                    }
//                    .transition(.move(edge: .top))
//                    .animation(.default)
                }
            }
        }
        .resignKeyboardOnDragGesture()
        .padding(.top, 10)
        .sheet(isPresented: $editMode, content: {
            VStack {
                NewCardFormView(viewModel: editCardFormModel)
                HStack(spacing: 20) {
                    Spacer()
                    Button("Update", action: {
                        if !editCardFormModel.validateForm() {
                            return
                        }
                        viewModel.update(
                            card: editCardFormModel.createEditCard(id: editCardModel.id),
                            secureFields: editCardFormModel.createEditSecureFieds(secureFieldsIds: editCardFormModel.formModel.secureFields)
                        )
                        editMode.toggle()
                    })
                    .font(.title3)
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
