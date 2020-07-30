import SwiftUI

struct HomeView: View {
    private(set) var adaptiveLayout = [GridItem(.adaptive(minimum: 250))]
    @ObservedObject var viewModel: CardsListViewModel
    
    var body: some View {
        if viewModel.cards.isEmpty {
//            NewCardFormView()
            VStack {
                AddNewCard()
            }
        } else {
            VStack {
                CardListView(viewModel: viewModel)
                Spacer()
                HStack {
                    Spacer()
                    AddNewCard()
//                    Button("\(Image(systemName: "plus")) Add new card", action: {
//                        viewModel.cards.forEach { (card) in
//                            viewModel.deleteCard(card)
//                        }
//                    })
                }
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: testViewModel)
    }
}
