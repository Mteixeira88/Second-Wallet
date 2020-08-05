import Foundation
import Amplify

class CardRepository: Repository {
    static let shared = CardRepository()
    
    func getAll(completion: @escaping(Result<[CardModel], RepositoryError>) -> Void) {
        Amplify.DataStore.query(CardModel.self) { result in
            switch result {
            case .success(let cards):
                completion(.success(cards))
            case .failure(let error):
                debugPrint("Failed getting all because of: \(error)")
                completion(.failure(RepositoryError.unableToGetAll))
            }
        }
    }
    
    func get(
        identifier: String,
        completion: @escaping(Result<CardModel, RepositoryError>) -> Void
    ) {
        Amplify.DataStore.query(CardModel.self, byId: identifier) { result in
            switch result {
            case .success(let card):
                guard let card = card else {
                    debugPrint("Failed getting the card \(identifier)")
                    return
                }
                completion(.success(card))
            case .failure(let error):
                debugPrint("Failed getting the card \(identifier) because of: \(error)")
                completion(.failure(RepositoryError.unableToGetOne))
            }
        }
    }
    
    func create(
        _ model: CardModel,
        completion: @escaping(RepositoryError?) -> Void
    ) {
        Amplify.DataStore.save(model) { (result) in
            switch result {
            case .success:
                completion(nil)
            case .failure(let error):
                debugPrint("Failed saving todo \(error)")
                completion(.unableToCreate)
                
            }
        }
    }
    
    func update(
        _ model: CardModel,
        completion: @escaping(RepositoryError?) -> Void
    ) {
        Amplify.DataStore.save(model, where: CardModel.keys.id.eq(model.id)) { (result) in
            switch result {
            case .success:
                completion(nil)
            case .failure(let error):
                debugPrint("Failed updating todo \(error)")
                completion(.unableToUpdate)
            }
        }
    }
    
    func delete(
        _ model: CardModel,
        completion: @escaping(RepositoryError?) -> Void
    ) {
        getAll { result in
            switch result {
            case .success(let cards):
                guard let deletedCard = cards.first(where: {$0 == model }) else {
                    debugPrint("Unable to index delete")
                    completion(.unableToDelete)
                    return
                }
                
                Amplify.DataStore.delete(deletedCard) { result in
                    switch result {
                    case .success:
                        completion(nil)
                    case .failure(let error):
                        debugPrint("Unable to delete: \(error)")
                        completion(.unableToDelete)
                    }
                }
            case .failure:
                completion(.unableToDelete)
            }
        }
    }
    
}
