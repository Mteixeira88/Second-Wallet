import SwiftUI

struct CardView: View {
    var viewModel: CardViewModel
    @State var flipped = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 20) {
                if flipped {
                    CardDetails(viewModel: CardDetailViewModel(card: viewModel.card))
                        .rotation3DEffect(.degrees(self.flipped ? 180 : 0.0), axis: (x: 0.0, y: 1.0, z: 0.0))
                } else {
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
                
            }
            .padding(.top, 32)
            .padding(.bottom, 16)
            .padding(.horizontal, 16)
//            Spacer()
        }
        .frame(minWidth: 200, maxWidth: .infinity, minHeight: 200, maxHeight: 200)
        .background(Color(viewModel.backgroundColor))
        .cornerRadius(8)
        .shadow(color: Color(UIColor.systemGray), radius: 5)
        .rotation3DEffect(.degrees(self.flipped ? 180 : 0.0), axis: (x: 0.0, y: 1.0, z: 0.0))
        .animation(.default)
        .onTapGesture {
            // explicitly apply animation on toggle (choose either or)
            //withAnimation {
            self.flipped.toggle()
            //}
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(viewModel: CardViewModel(card: cardsPreview[1]))
    }
}
