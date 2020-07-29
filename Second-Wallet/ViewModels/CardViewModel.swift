import Amplify
import Combine

enum MutationType: String {
    case create = "create"
    case delete = "delete"
}

class CardViewModel: ObservableObject {
    @Published var cards: [CardModel]
    
    init(cards: [CardModel] = []) {
        self.cards = cards
        CardRepository.shared.getAll { result in
            switch result {
            case .success(let cards):
                self.cards = cards
                self.observeCards()
            case .failure:
                fatalError("Something went wrong on init cards")
            }
        }
    }
    
    func observeCards() {
        let _ = Amplify.DataStore.publisher(for: CardModel.self)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    fatalError("Observe failed \(error)")
                }
            }, receiveValue: { mutationEvent in
                guard let card = try? mutationEvent.decodeModel(as: CardModel.self) else {
                    return
                }
                switch mutationEvent.mutationType {
                case MutationType.create.rawValue:
                    self.cards.append(card)
                case MutationType.delete.rawValue:
                    if let index = self.cards.firstIndex(of: card) {
                        self.cards.remove(at: index)
                    }
                default:
                    break
                }
            })
    }
    
    func createNew(card: CardModel, secureFields: [SecureFieldModel]) {
        CardRepository.shared.create(card) { (result) in
            if result == nil {
                fatalError("Unable To Create")
            }
            secureFields.forEach { (secureField) in
                Amplify.DataStore.save(secureField) { (result) in
                    switch result {
                    case .success:
                        break
                    case .failure(let error):
                        fatalError("Failed saving Secure Field \(error)")
                    }
                }
            }
        }
    }
    
    func deleteCard(_ card: CardModel) {
        CardRepository.shared.delete(card) { (result) in
            if result == nil {
                fatalError("Unable To Delete")
            }
        }
    }
}


