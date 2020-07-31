import Amplify

class CardsListViewModel: ObservableObject {
    @Published var cards: [CardModel]
    
    init(cards: [CardModel] = []) {
        self.cards = cards
        CardRepository.shared.getAll { [weak self] result in
            switch result {
            case .success(let cards):
                self?.cards = cards.reversed()
            case .failure:
                fatalError("Something went wrong on init cards")
            }
        }
    }
    
    func createNew(card: CardModel, secureFields: [SecureFieldModel]) {
        CardRepository.shared.create(card) { [weak self] (result) in
            if result != nil {
                fatalError("Unable To Create")
            }
            
            var indexSecure = 0
            
            while indexSecure != secureFields.count - 1 {
                let saveSecureField = SecureFieldModel(
                    title: secureFields[indexSecure].title,
                    value: secureFields[indexSecure].value,
                    card: card
                )
                Amplify.DataStore.save(saveSecureField) { (result) in
                    switch result {
                    case .success:
                        self?.cards.insert(card, at: 0)
                        indexSecure += 1
                    case .failure(let error):
                        fatalError("Failed saving Secure Field \(error)")
                    }
                }
            }
        }
    }
    
    func deleteCard(_ card: CardModel) {
        CardRepository.shared.delete(card) { [weak self] (result) in
            if result != nil {
                fatalError("Unable To Delete")
            }
            if let index = self?.cards.firstIndex(of: card) {
                self?.cards.remove(at: index)
            }
        }
    }
}

// Preview purposes
let cardsPreview = [
    CardModel(id: UUID().uuidString, digits: "123", tag: "Banco", brand: "Bankinter", backgroundColor: "whiteColor"),
    CardModel(id: UUID().uuidString, tag: "Telefone", brand: "Vodafone", backgroundColor: "whiteColor"),
    CardModel(id: UUID().uuidString, tag: "House codes", brand: "Dierre", backgroundColor: "whiteColor")
]
let testViewModel = CardsListViewModel(cards: cardsPreview)
