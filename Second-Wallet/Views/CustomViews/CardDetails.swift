import SwiftUI

struct CardDetails: View {
    let rows = [GridItem(.flexible(minimum: 10, maximum: .infinity))]
    var viewModel: CardDetailViewModel
    
    @State var showSecureFields = false
    
    @Binding var countdown: Int
    
    var body: some View {
        VStack(spacing: 30) {
            HStack(alignment: .bottom) {
                Text("\(countdown) sec")
                    .flipsForRightToLeftLayoutDirection(true)
                    .foregroundColor(viewModel.backgroundColor.oppositeDarkColor)
                    Spacer()
                
                Button(action: {
                    if !showSecureFields {
                        viewModel.checkBiometric { (result) in
                            showSecureFields = result
                        }
                    } else {
                        showSecureFields = false
                    }
                }){
                    Image(systemName: showSecureFields ? "lock.open.fill" : "lock.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 20)
                }
                .foregroundColor(viewModel.backgroundColor.oppositeDarkColor)
                
            }
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows, alignment: .center, spacing: 20) {
                    ForEach(viewModel.secureFields) { secure in
                        HStack {
                            Spacer()
                            VStack(alignment: .center) {
                                Text(secure.title)
                                    .font(.title)
                                    .foregroundColor(viewModel.backgroundColor.sameDarkColor)
                                Text(secure.value)
                                    .foregroundColor(viewModel.backgroundColor.sameDarkColor)
                                    .opacity(showSecureFields ? 1 : 0)
                            }
                            Spacer()
                        }
                    }
                    .padding(24)
                    .background(viewModel.backgroundColor.oppositeDarkColor)
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
