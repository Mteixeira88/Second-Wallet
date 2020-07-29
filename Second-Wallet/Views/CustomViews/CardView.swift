import SwiftUI

struct CardView: View {
    var viewModel: CardViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(viewModel.firstTitle)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(viewModel.backgroundColor.isDarkColor ? Color.white : Color.black)
                    Text(viewModel.secondTitle.uppercased())
                        .font(.title3)
                        .foregroundColor(viewModel.backgroundColor.isDarkColor ? Color.white : Color.black)
                }
                
                Text(viewModel.thirdTitle.uppercased())
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(viewModel.backgroundColor.isDarkColor ? Color.white : Color.black)
                
                HStack {
                    Spacer()
                    
                    Text(viewModel.date)
                        .font(.caption)
                        .foregroundColor(viewModel.backgroundColor.isDarkColor ? Color.white : Color.black)
                }
                
                
            }
            .padding(.top, 32)
            .padding(.bottom, 16)
            .padding(.horizontal, 16)
            Spacer()
        }
        .background(Color(viewModel.backgroundColor))
        .cornerRadius(8)
        .shadow(radius: 5)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(viewModel: CardViewModel(card: cardsPreview[1]))
    }
}
