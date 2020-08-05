
import Foundation
import Amplify

class SecureFieldRepository: Repository {
    static let shared = SecureFieldRepository()
    
    func getAll(completion: @escaping(Result<[SecureFieldModel], RepositoryError>) -> Void) {
        Amplify.DataStore.query(SecureFieldModel.self) { result in
            switch result {
            case .success(let securityFields):
                completion(.success(securityFields))
            case .failure(let error):
                debugPrint("Failed getting all because of: \(error)")
                completion(.failure(RepositoryError.unableToGetAll))
            }
        }
    }
    
    func get(
        identifier: String,
        completion: @escaping(Result<SecureFieldModel, RepositoryError>) -> Void
    ) {
        Amplify.DataStore.query(SecureFieldModel.self, byId: identifier) { result in
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
        _ model: SecureFieldModel,
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
        _ model: SecureFieldModel,
        completion: @escaping(RepositoryError?) -> Void
    ) {
        Amplify.DataStore.save(model, where: SecureFieldModel.keys.id.eq(model.id)) { (result) in
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
        _ model: SecureFieldModel,
        completion: @escaping(RepositoryError?) -> Void
    ) {
        getAll { result in
            switch result {
            case .success(let securityFields):
                guard let deleteSecurityField = securityFields.first(where: {$0.id == model.id }) else {
                    debugPrint("Unable to index delete")
                    completion(.unableToDelete)
                    return
                }
                
                Amplify.DataStore.delete(deleteSecurityField) { result in
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
