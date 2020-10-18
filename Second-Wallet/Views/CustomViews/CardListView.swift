import SwiftUI

struct CardListView: View {
    private(set) var adaptiveLayout = [GridItem(.adaptive(minimum: 300))]
    var viewModel: CardsListViewModel
    
    @State var editMode = false
    @State var editCardFormModel = NewCardViewModel()
    @State var editCardModel = CardModel(tag: "", brand: "", backgroundColor: "")
    
    @State private(set) var flippedCard = false
    @State private(set) var selectedCard = ""
    @State var position = CGPoint()
    
    var body: some View {
        Text("Tap card for details")
            .font(.subheadline)
            .foregroundColor(Color(UIColor.systemGray2))
            .padding(.top, 10)
            .opacity(flippedCard ? 0 : 1)
            .animation(.easeInOut)
        GeometryReader { fullView in
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: adaptiveLayout, spacing: 20) {
                    ForEach(viewModel.cards) { card in
                        GeometryReader { gp in
                            CardView(viewModel: CardViewModel(card: card)) { actions in
                                switch actions {
                                case .delete:
                                    viewModel.deleteCard(card)
                                case .edit:
                                    editCardModel = card
                                    editCardFormModel.editCard(card: card)
                                    editMode.toggle()
                                }
                            } isFlipped: { state in
                                flippedCard = state
                                if state {
                                    let area = fullView.frame(in: CoordinateSpace.global)
                                    let frame = gp.frame(in: CoordinateSpace.global)
//                                    (area.height / 2) - frame.minY - 60)
                                    position = CGPoint(x: -2, y: area.minY - frame.minY + 30)
                                }
                                
                                withAnimation {
                                    selectedCard = flippedCard ? card.id : ""
                                }
                            }
                            .offset(
                                x: flippedCard && selectedCard == card.id ? position.x : 0,
                                y: flippedCard && selectedCard == card.id ? position.y : 0
                            )
                            .opacity(flippedCard && selectedCard != card.id ? 0.5 : 1)
                            .blur(radius: flippedCard && selectedCard != card.id ? 20 : 0)
                            .disabled(selectedCard != card.id && selectedCard != "" ? true : false)
                        }
                        .frame(width: fullView.frame(in: CoordinateSpace.global).width - 20, height: 200)
                        .zIndex(flippedCard && selectedCard != card.id ? 0 : 1)
                    }
                }
            }
            .resignKeyboardOnDragGesture()
        }
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
