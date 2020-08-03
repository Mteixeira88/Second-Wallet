import SwiftUI

struct CardDetails: View {
    let rows = [GridItem(.flexible(minimum: 10, maximum: .infinity))]
    var viewModel: CardDetailViewModel
    
    @State var showSecureFields = false
    
    @Binding var countdown: Int
    
    var body: some View {
        VStack(spacing: 30) {
            HStack(alignment: .bottom) {
//                Image(systemName: "gobackward")
//                    .foregroundColor(viewModel.backgroundColor.isDarkColor)
                Text("\(countdown) sec")
                    .flipsForRightToLeftLayoutDirection(true)
                    .foregroundColor(viewModel.backgroundColor.isDarkColor)
                    Spacer()
                Image(systemName: showSecureFields ? "lock.open.fill" : "lock.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 20, height: 20)
                    .foregroundColor(viewModel.backgroundColor.isDarkColor)
                    .onTapGesture {
                        if !showSecureFields {
                            viewModel.checkBiometric { (result) in
                                showSecureFields = result
                            }
                        } else {
                            showSecureFields = false
                        }
                    }
            }
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, alignment: .center, spacing: 20) {
                    ForEach(viewModel.secureFields) { secure in
                        HStack {
                            Spacer()
                            VStack(alignment: .center) {
                                Text(secure.title)
                                    .font(.title)
                                    .foregroundColor(Color.white)
                                Text(secure.value)
                                    .foregroundColor(Color.white)
                                    .opacity(showSecureFields ? 1 : 0)
                            }
                            Spacer()
                        }
                    }
                    .padding(24)
                    .background(Color.green)
                    .cornerRadius(8)
                }
            }
            .frame(height: 100)
        }
    }
}

struct CardDetails_Previews: PreviewProvider {
    static var previews: some View {
        CardDetails(viewModel: testSecureFields, countdown: .constant(300))
    }
}
