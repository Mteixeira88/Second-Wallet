import Amplify
import Foundation
import UIKit

class CardsListViewModel: ObservableObject {
    @Published var cards: [CardModel]
    private var filterCard: [CardModel]
    
    init(cards: [CardModel] = []) {
        self.cards = cards
        self.filterCard = cards
        
        CardRepository.shared.getAll { [weak self] result in
            switch result {
            case .success(let cards):
                self?.cards = cards.reversed()
                self?.filterCard = cards.reversed()
            case .failure:
                fatalError("Something went wrong on init cards")
            }
        }
    }
    
    func createNew(card: CardModel, secureFields: [SecureFieldModel]) {
        CardRepository.shared.create(card) { [weak self] (result) in
            guard let self = self else {
                return
            }
            if result != nil {
                fatalError("Unable To Create")
            }
            let defaultPosition = 0
            self.cards.insert(card, at: defaultPosition)
            
            secureFields.enumerated().forEach { (index, secureField) in
                let saveSecureField = SecureFieldModel(
                    title: secureField.title,
                    value: secureField.value,
                    card: card
                )
                Task {
                    do {
                        try await Amplify.DataStore.save(saveSecureField)
                        if index == secureFields.count - 1 {
                            self.cards[defaultPosition].secureFields = List(elements: secureFields)
                            self.filterCard = self.cards
                        }
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
    
    func update(card: CardModel, secureFields: [SecureFieldModel]) {
        CardRepository.shared.update(card) { [weak self] (result) in
            guard let self = self else {
                return
            }
            if result != nil {
                fatalError("Unable to update")
            }
            
            guard let indexCard = self.cards.firstIndex(where: { $0.id == card.id }) else {
                return
            }
            
            self.cards[indexCard] = card
            secureFields.enumerated().forEach { (index, secureField) in
                let saveSecureField = SecureFieldModel(
                    id: secureField.id,
                    title: secureField.title,
                    value: secureField.value,
                    card: card
                )
                
                SecureFieldRepository.shared.update(saveSecureField) { [weak self] (result) in
                    if result != nil {
                        SecureFieldRepository.shared.create(saveSecureField) { [weak self] (resultCreate) in
                            if resultCreate != nil {
                                return
                            }
                            self?.updateSecureFields(at: index, on: indexCard, with: secureFields)
                        }
                        return
                    }
                    self?.updateSecureFields(at: index, on: indexCard, with: secureFields)
                }
            }
        }
    }
    
    func updateSecureFields(at index: Int,on indexCard: Int, with secureFields: [SecureFieldModel]) {
        if index == secureFields.count - 1 {
            cards[indexCard].secureFields = List(elements: secureFields)
            filterCard = cards
        }
    }
    
    func deleteCard(_ card: CardModel) {
        CardRepository.shared.delete(card) { [weak self] (result) in
            if result != nil {
                fatalError("Unable To Delete")
            }
            if let index = self?.cards.firstIndex(of: card) {
                self?.cards.remove(at: index)
                self?.filterCard.remove(at: index)
            }
        }
    }
    
    func searchCard(query: String) {
        cards = []
        if query.trimmingCharacters(in: .whitespaces).isEmpty {
            cards = filterCard
            return
        }

        cards = filterCard.filter({
            $0.brand.lowercased().contains(query.lowercased()) ||
                $0.tag.lowercased().contains(query.lowercased())
        })
    }
}

// Preview purposes
let cardsPreview = [
    CardModel(id: UUID().uuidString, digits: "123", tag: "Bank", brand: "My Banks name", backgroundColor: UIColor(Assets.colors(.brand)).toHexString(),
              secureFields: [
                  SecureFieldModel(title: "Username", value: "MNT20192"),
                  SecureFieldModel(title: "Code", value: "333312312")
              ]),
    CardModel(id: UUID().uuidString, tag: "SIM card", brand: "My Provider", backgroundColor: UIColor.red.toHexString(),
              secureFields: [
                  SecureFieldModel(title: "Pin", value: "1234"),
                  SecureFieldModel(title: "Puk", value: "111122223333")
              ]),
    CardModel(id: UUID().uuidString, tag: "House codes", brand: "My House Provider", backgroundColor: UIColor.blue.toHexString(),
              secureFields: [
                  SecureFieldModel(title: "Door Code", value: "123123"),
                  SecureFieldModel(title: "Light Code", value: "LG3333")
              ])
]
let testViewModel = CardsListViewModel(cards: cardsPreview)
