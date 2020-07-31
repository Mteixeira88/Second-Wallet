import SwiftUI

struct HomeView: View {
    private(set) var adaptiveLayout = [GridItem(.adaptive(minimum: 250))]
    @ObservedObject var viewModel: CardsListViewModel
    
    var body: some View {
        if viewModel.cards.isEmpty {
            VStack {
                AddNewCard(viewModel: viewModel)
            }
        } else {
            VStack {
                CardListView(viewModel: viewModel)
                Spacer()
                HStack {
                    Spacer()
                    AddNewCard(viewModel: viewModel)
                    Button("\(Image(systemName: "plus")) Delete cards test", action: {
                        viewModel.cards.forEach { (card) in
                            viewModel.deleteCard(card)
                        }
                    })
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
