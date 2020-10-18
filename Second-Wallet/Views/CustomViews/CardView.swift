import SwiftUI
import UIKit

enum ContextMenuActions {
    case edit, delete
}

struct CardView: View {
    var viewModel: CardViewModel
    
    var actions: (ContextMenuActions) -> Void
    var isFlipped: (Bool)->Void
    
    @State private(set) var flipped = false
    @State private(set) var countdown = 180
    
    @State private(set) var timer: Timer?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 20) {
                if flipped {
                    CardDetails(viewModel: viewModel, countdown: $countdown)
                        .rotation3DEffect(
                            .degrees(self.flipped ? 180 : 0.0),
                            axis: (x: 0.0, y: 1.0, z: 0.0)
                        )
                } else {
                    CardPreview(viewModel: viewModel)
                        .padding(.vertical, 24)
                        .padding(.horizontal, 16)
                }
                Spacer()
            }
        }
        .background(Color(viewModel.backgroundColor))
        .cornerRadius(8)
        .onTapGesture {
            flipped.toggle()
            isFlipped(flipped)
            if timer != nil {
                timer!.invalidate()
            }
            if flipped {
                countdown = 180
                timeout()
            }
            UIApplication.shared.sendAction(
                #selector(UIResponder.resignFirstResponder),
                to: nil,
                from: nil,
                for: nil
            )
        }
        .contextMenu {
            if !flipped {
                Button(action: {
                    viewModel.checkBiometric { (result) in
                        if result {
                            actions(.edit)
                        }
                    }
                }) {
                    Text("Edit")
                }
                
                Button(action: {
                    viewModel.checkBiometric { (result) in
                        if result {
                            actions(.delete)
                        }
                    }
                }) {
                    Text("Delete")
                }
            }
        }
        .onReceive(
            NotificationCenter.default.publisher(
                for: UIApplication.didEnterBackgroundNotification)) { _ in
            flipped = false
            isFlipped(flipped)
        }
        .rotation3DEffect(
            .degrees(self.flipped ? 180 : 0.0),
            axis: (x: 0.0, y: 1.0, z: 0.0)
        )
        .animation(.default)
    }
    
    
    func timeout() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            countdown -= 1
            if countdown == 0 {
                timer.invalidate()
                flipped = false
                isFlipped(flipped)
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(viewModel: CardViewModel(card: cardsPreview[1])) { actions in
            switch actions {
            case .delete:
                break
            case .edit:
                break
            }
        } isFlipped: { state in
            
        }
    }
}
