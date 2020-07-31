import UIKit

struct CardViewModel {
    private(set) var card: CardModel
    
    init(card: CardModel) {
        self.card = card
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
