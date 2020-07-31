import SwiftUI

struct CardListView: View {
    private(set) var adaptiveLayout = [GridItem(.adaptive(minimum: 300))]
    var viewModel: CardsListViewModel
    @State var flipped = false
    
    var body: some View {
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
    }
}

struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        CardListView(viewModel: testViewModel)
    }
}
