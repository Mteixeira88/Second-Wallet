import UIKit
import Amplify
import LocalAuthentication
import Foundation

class CardViewModel: ObservableObject {
    
    private(set) var card: CardModel
    
    @Published var secureFields: [SecureFieldModel] = []
    
    init(card: CardModel) {
        self.card = card
        getSecureFields()
    }
    
    func getSecureFields() {
        
        Task {
            try await card.secureFields?.fetch()
            
            guard let fields = card.secureFields else {
                return
            }
            
            let secure: [SecureFieldModel] = fields.map ({ secure in
                SecureFieldModel(
                    id: secure.id,
                    title: secure.title,
                    value: secure.value,
                    card: secure.card
                )
            })
            
            DispatchQueue.main.async {
                self.secureFields = secure
            }
            
        }
    }
    
    func checkBiometric(
        reason: String = "In order proceed, we need to check it's really you.",
        completion: @escaping(Bool) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            }
        } else {
            completion(false)
        }
        
    }
    
    func copyToClipboard(_ text: String) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = text
    }
}

extension CardViewModel {
    var firstTitle: String {
        guard let digits = card.digits else {
            return "**** **** **** ****"
        }
        return "contains \(digits)"
    }
    
    var secondTitle: String {
        return card.tag
    }
    
    var thirdTitle: String {
        return card.brand
    }
    
    var date: String {
        guard let date = card.lastOpen else {
            return "Never opened"
        }
        return "Last open: \(date)"
    }
    
    var backgroundColor: UIColor {
        return UIColor(hexString: card.backgroundColor) ?? UIColor.blue
    }
}
