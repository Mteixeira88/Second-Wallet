import SwiftUI

struct CardDetails: View {
    let rows = [GridItem(.flexible(minimum: 10, maximum: .infinity))]
    var viewModel: CardViewModel
    
    @State private(set) var showSecureFields = false
    
    @State private(set) var listHeight = 0
    @State private(set) var secureValue: String? = nil
    
    @Binding var countdown: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(alignment: .bottom) {
                Text("\(countdown) sec")
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
                    Image(
                        systemName:
                            showSecureFields ?
                            SFSymbols.lockerOpen.rawValue :
                            SFSymbols.locker.rawValue
                    )
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 20)
                }
                .foregroundColor(viewModel.backgroundColor.oppositeDarkColor)
                
            }
            .padding(.top, 24)
            .padding(.horizontal, 16)
            Text("Tap the locker icon and verify your biometric to see the card details.")
                .font(.caption)
                .foregroundColor(viewModel.backgroundColor.oppositeDarkColor)
                .frame(height: 35)
                .padding(.horizontal)
            ScrollView {
                ForEach(viewModel.secureFields) { secure in
                    Button(action: {
                        if showSecureFields {
                            secureValue = secure.title
                            viewModel.copyToClipboard(secure.value)
                        }
                    }) {
                        HStack {
                            Text(secure.title)
                                .foregroundColor(Color(UIColor.label))
                            Spacer()
                            Text(secure.value)
                                .font(.footnote)
                                .foregroundColor(Color(UIColor.label))
                                .blur(radius: showSecureFields ? 0 : 10)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                    }
                    .background(Assets.colors(.inputBackground))
                }
            }
            .frame(height: CGFloat(listHeight))
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    listHeight = (50 * viewModel.secureFields.count) < 300 ? (50 * viewModel.secureFields.count) : 300
                }
            }
            Text("\(Image(systemName: SFSymbols.info.rawValue)) Tap the card detail to copy to clipboard")
                .font(.caption)
                .foregroundColor(viewModel.backgroundColor.oppositeDarkColor)
                .frame(height: showSecureFields ? 16 : 0)
                .opacity(showSecureFields ? 1 : 0)
                .padding(.horizontal)
                .animation(.easeInOut)
            if let secure = secureValue {
                Text("\(Image(systemName: SFSymbols.clipboard.rawValue)) \(secure) copied to clipboard")
                    .font(.caption)
                    .foregroundColor(viewModel.backgroundColor.oppositeDarkColor)
                    .frame(height: 40)
                    .padding(.horizontal)
                    .onAppear() {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            secureValue = nil
                        }
                    }
                    .animation(.easeInOut)
            }
        }
    }
}

struct CardDetails_Previews: PreviewProvider {
    static var previews: some View {
        CardDetails(viewModel: CardViewModel(card: cardsPreview[1]), countdown: .constant(180))
    }
}
