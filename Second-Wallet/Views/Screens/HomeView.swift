import SwiftUI

struct HomeView: View {
    private(set) var adaptiveLayout = [GridItem(.adaptive(minimum: 250))]
    @ObservedObject var viewModel: CardsListViewModel
    
    @State var searchText = ""
    @State var isSearching = false
    @State var showSearch = false
    
    var body: some View {
        NavigationView {
            if viewModel.cards.isEmpty,
               !isSearching {
                VStack {
                    AddNewCard(viewModel: viewModel)
                }
            } else {
                VStack {
                    if showSearch {
                        SearchBarView(
                            searchText: $searchText,
                            onSearching: { status in
                                isSearching = status
                                viewModel.searchCard(query: searchText)
                            }
                        )
                        .transition(.move(edge: .top))
                        .animation(.default)
                    }
                    CardListView(viewModel: viewModel)
                    Spacer()
                    HStack {
                        Spacer()
                        AddNewCard(viewModel: viewModel)
                    }
                }
                .padding()
                .navigationBarItems(
                    leading: Image("logo").resizable()
                        .frame(width: 30, height: 25),
                    trailing: Button(action: {
                        showSearch.toggle()
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color("brand"))
                    }
                )
                .navigationBarTitle("Second Wallet", displayMode: .inline)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: testViewModel)
    }
}
