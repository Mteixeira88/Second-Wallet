import Amplify

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
                Amplify.DataStore.save(saveSecureField) { (result) in
                    switch result {
                    case .success:
                        if index == secureFields.count - 1 {
                            self.cards[defaultPosition].secureFields = List(secureFields)
                            self.filterCard = self.cards
                        }
                    case .failure(let error):
                        fatalError("Failed saving Secure Field \(error)")
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
                Amplify.DataStore.save(saveSecureField, where: SecureFieldModel.keys.id.eq(secureField.id)) { (result) in
                    switch result {
                    case .success:
                        if index == secureFields.count - 1 {
                            self.cards[indexCard].secureFields = List(secureFields)
                            self.filterCard = self.cards
                        }
                    case .failure:
                        Amplify.DataStore.save(saveSecureField) { (result) in
                            switch result {
                            case .success:
                                if index == secureFields.count - 1 {
                                    self.cards[indexCard].secureFields = List(secureFields)
                                    self.filterCard = self.cards
                                }
                            case .failure(let error):
                                fatalError("Failed saving Secure Field \(error)")
                            }
                        }
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

        cards = filterCard.filter({ $0.brand.lowercased().contains(query.lowercased()) })
    }
}

// Preview purposes
let cardsPreview = [
    CardModel(id: UUID().uuidString, digits: "123", tag: "Banco", brand: "Bankinter", backgroundColor: "whiteColor",
              secureFields: [
                  SecureFieldModel(title: "I'm a title", value: "123123"),
                  SecureFieldModel(title: "I'm a title 2", value: "3333"),
                  SecureFieldModel(title: "I'm a title 3", value: "44444")
              ]),
    CardModel(id: UUID().uuidString, tag: "Telefone", brand: "Vodafone", backgroundColor: "whiteColor",
              secureFields: [
                  SecureFieldModel(title: "I'm a title", value: "123123"),
                  SecureFieldModel(title: "I'm a title 2", value: "3333"),
                  SecureFieldModel(title: "I'm a title 3", value: "44444")
              ]),
    CardModel(id: UUID().uuidString, tag: "House codes", brand: "Dierre", backgroundColor: "whiteColor",
              secureFields: [
                  SecureFieldModel(title: "I'm a title", value: "123123"),
                  SecureFieldModel(title: "I'm a title 2", value: "3333"),
                  SecureFieldModel(title: "I'm a title 3", value: "44444")
              ])
]
let testViewModel = CardsListViewModel(cards: cardsPreview)
