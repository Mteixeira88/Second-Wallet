import SwiftUI

struct CardPreview: View {
    var viewModel: CardViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(viewModel.firstTitle)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(viewModel.backgroundColor.oppositeDarkColor)
                    Text(viewModel.secondTitle.uppercased())
                        .font(.title3)
                        .foregroundColor(viewModel.backgroundColor.oppositeDarkColor)
                }
                
                Text(viewModel.thirdTitle.uppercased())
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(viewModel.backgroundColor.oppositeDarkColor)
            }
            Spacer()
        }
    }
}

struct CardPreview_Previews: PreviewProvider {
    static var previews: some View {
        CardPreview(viewModel: CardViewModel(card: cardsPreview[1]))
    }
}
