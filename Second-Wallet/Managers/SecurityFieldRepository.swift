
import Foundation
import Amplify

class SecureFieldRepository: Repository {
    static let shared = SecureFieldRepository()
    
    func getAll(completion: @escaping(Result<[SecureFieldModel], RepositoryError>) -> Void) {
        
        Task {
            
            do {
                let result = try await Amplify.DataStore.query(SecureFieldModel.self)
                completion(.success(result))
            } catch {
                debugPrint("Failed getting all because of: \(error)")
                completion(.failure(RepositoryError.unableToGetAll))
            }
        }
    }
    
    func get(
        identifier: String,
        completion: @escaping(Result<SecureFieldModel, RepositoryError>) -> Void
    ) {
        
        Task {
            
            do {
                guard let result = try await Amplify.DataStore.query(SecureFieldModel.self, byId: identifier) else {
                    completion(.failure(RepositoryError.unableToGetAll))
                    return
                }
                completion(.success(result))
            } catch {
                debugPrint("Failed getting all because of: \(error)")
                completion(.failure(RepositoryError.unableToGetAll))
            }
        }
    }
    
    func create(
        _ model: SecureFieldModel,
        completion: @escaping(RepositoryError?) -> Void
    ) {
        Task {
            do {
                try await Amplify.DataStore.save(model)
                completion(nil)
            } catch {
                debugPrint("Failed saving todo \(error)")
                completion(.unableToCreate)
            }
        }
    }
    
    func update(
        _ model: SecureFieldModel,
        completion: @escaping(RepositoryError?) -> Void
    ) {
        Task {
            do {
                try await Amplify.DataStore.save(model, where: CardModel.keys.id.eq(model.id))
                completion(nil)
            } catch {
                debugPrint("Failed saving todo \(error)")
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
                
                Task {
                    do {
                        try await Amplify.DataStore.delete(deleteSecurityField)
                        completion(nil)
                    } catch {
                        debugPrint("Failed saving todo \(error)")
                        completion(.unableToDelete)
                    }
                }
            case .failure:
                completion(.unableToDelete)
            }
        }
    }
    
}
