import SwiftUI

struct EmptyView: View {
    
    @State private(set) var number = 0
    @State private(set) var cards = cardsPreview
    var body: some View {
        VStack(spacing: 30) {
            VStack {
                Image("logo").resizable()
                    .foregroundColor(Assets.colors(.brand))
                    .frame(width: 100, height: 85)
                Text("Let's start filling up your")
                    .multilineTextAlignment(.center)
                    .font(.title3)
                Text("SecondWallet")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Assets.colors(.brand))
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        number += 1
                        
                        if number == cards.count {
                            number = 0
                        }
                    }) {
                        Text("\(Assets.systemIcon(.plus)) More examples")
                            .font(.subheadline)
                    }
                }
                CardView(viewModel: CardViewModel(card: cards[number])) { (actions) in
                    switch actions {
                    case .edit, .delete:
                        break
                    }
                } isFlipped: { state in
                    
                }
            }
//            .redacted(reason: .placeholder)
        }
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
