enum RepositoryError: String, Error {
    case unableToGetAll = "Unable to get all the elements"
    case unableToCreate = "Unable to create element"
    case unableToUpdate = "Unable to update element"
    case unableToGetOne = "Unable to get one element"
    case unableToDelete = "Data received invalid. Please try again"
}

protocol Repository {

    associatedtype Model

    func getAll(completion: @escaping(Result<[Model], RepositoryError>) -> Void)
    func get(identifier: String, completion: @escaping(Result<Model, RepositoryError>) -> Void)
    func create(_ model: Model, completion: @escaping(RepositoryError?) -> Void)
    func update(_ model: Model, completion: @escaping(RepositoryError?) -> Void)
    func delete(_ model: Model, completion: @escaping(RepositoryError?) -> Void)
}
