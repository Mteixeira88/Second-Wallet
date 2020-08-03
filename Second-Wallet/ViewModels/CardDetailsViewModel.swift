import UIKit
import LocalAuthentication

class CardDetailViewModel {
    private(set) var secureFields: [SecureFieldModel]
    
    init(card: CardModel) {
        var secureFields = [SecureFieldModel]()
        card.secureFields?.forEach({ (secureField) in
            secureFields.append(
                SecureFieldModel(
                    id: secureField.id,
                    title: secureField.title,
                    value: secureField.value,
                    card: secureField.card
                )
            )
        })
        self.secureFields = secureFields
    }
    
    func checkBiometric(completion: @escaping(Bool) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
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
}

extension CardDetailViewModel {
    var backgroundColor: UIColor {
        guard let card = secureFields[0].card else {
            return .blue
        }
        return UIColor(hexString: card.backgroundColor) ?? .blue
    }
}


let testSecureFields = CardDetailViewModel(card: cardsPreview[0])
