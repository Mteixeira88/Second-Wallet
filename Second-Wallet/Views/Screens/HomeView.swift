import SwiftUI

struct HomeView: View {
    private(set) var adaptiveLayout = [GridItem(.adaptive(minimum: 250))]
    @ObservedObject var viewModel: CardsListViewModel
    
    @State var searchText = ""
    @State var isSearching = false
    
    var body: some View {
        if viewModel.cards.isEmpty,
           !isSearching {
            VStack {
                AddNewCard(viewModel: viewModel)
            }
        } else {
            VStack {
                SearchBarView(searchText: $searchText, onSearching: { status in
                    isSearching = status
                    viewModel.searchCard(query: searchText)
                })
                CardListView(viewModel: viewModel)
                Spacer()
                HStack {
                    Spacer()
                    AddNewCard(viewModel: viewModel)
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: testViewModel)
    }
}
