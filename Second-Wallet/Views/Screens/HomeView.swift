import SwiftUI

struct HomeView: View {
    private(set) var adaptiveLayout = [GridItem(.adaptive(minimum: 250))]
    @ObservedObject var viewModel = CardsListViewModel()
    
    @State var searchText = ""
    @State var isSearching = false
    @State var showSearch = false
    
    var body: some View {
        NavigationView {
            if viewModel.cards.isEmpty,
               !isSearching {
                VStack {
                    EmptyView()
                        .padding()
                    AddNewCard(viewModel: viewModel)
                    Spacer()
                }
            } else {
                ZStack {
                    VStack {
                        CardListView(viewModel: viewModel)
                    }
                    .padding(.top, showSearch ? 60 : 0)
                    .padding(.bottom, 60)
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
                            .padding(.top, 5)
                        }
                        
                        Spacer()
                        HStack {
                            Spacer()
                            AddNewCard(viewModel: viewModel)
                        }
                        .padding()
                        .background(Color(UIColor.systemBackground))
                    }
                }
                .padding(.horizontal)
                .navigationBarItems(
                    leading: Image("logo")
                        .resizable()
                        .frame(width: 30, height: 25)
                        .foregroundColor(Assets.colors(.brand)),
                    trailing: Button(action: {
                        showSearch.toggle()
                    }) {
                        Image(
                            systemName:
                                showSearch ?
                                SFSymbols.magnifyGlassMinus.rawValue :
                                SFSymbols.magnifyGlassPlus.rawValue
                        )
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Assets.colors(.brand))
                    }
                )
                .navigationBarTitle("Second Wallet", displayMode: .inline)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: testViewModel)
    }
}
