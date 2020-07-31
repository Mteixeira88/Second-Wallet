import SwiftUI

struct CardDetails: View {
    let rows = [GridItem(.fixed(240))]
    var viewModel: CardDetailViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, alignment: .center, spacing: 20) {
                ForEach(viewModel.secureFields) { secure in
                    HStack {
                        Spacer()
                        VStack(alignment: .center) {
                            Text(secure.title)
                                .font(.title)
                                .foregroundColor(Color.white)
                                .frame(height: 50)
                            Text(secure.value)
                                .foregroundColor(Color.white)
                        }
                        Spacer()
                    }
                    .padding(24)
                    .background(Color.green)
                    .cornerRadius(8)
                }
            }
        }
        
    }
}

struct CardDetails_Previews: PreviewProvider {
    static var previews: some View {
        CardDetails(viewModel: testSecureFields)
    }
}
