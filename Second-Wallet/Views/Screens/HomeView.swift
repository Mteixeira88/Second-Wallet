import SwiftUI

struct HomeView: View {
    private(set) var adaptiveLayout = [GridItem(.adaptive(minimum: 250))]
    @ObservedObject var viewModel: CardsListViewModel
    
    var body: some View {
        if viewModel.cards.isEmpty {
            VStack {
                Button("Add new card", action: {
                    let card = CardModel(tag: "Banco", brand: "Bankinter", backgroundColor: "#ffffff")
                    let secureFields = [SecureFieldModel(title: "Password", value: "1234", card: card)]
                    
                    let card2 = CardModel(tag: "Mobile", brand: "Vodafone", backgroundColor: "#08158B")
                    let secureFields2 = [SecureFieldModel(title: "Password", value: "1234", card: card2)]

                    viewModel.createNew(card: card, secureFields: secureFields)
                    
                    viewModel.createNew(card: card2, secureFields: secureFields2)
                })
            }
        } else {
            VStack {
                ScrollView {
                    Text("Tap a card for settings")
                        .font(.body)
                        .foregroundColor(Color(UIColor.systemGray2))
                    LazyVGrid(columns: adaptiveLayout, spacing: 20) {
                        ForEach(viewModel.cards) { card in
                            CardView(viewModel: CardViewModel(card: card))
                        }
                    }
                    .padding()
                }
                Spacer()
                Button("Add new card", action: {
                    viewModel.cards.forEach { (card) in
                        viewModel.deleteCard(card)
                    }
                })
            }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: testViewModel)
    }
}
