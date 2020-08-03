import UIKit


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
