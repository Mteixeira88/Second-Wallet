// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "1fef853e83d91a76f828fbae6e072986"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: CardModel.self)
    ModelRegistry.register(modelType: SecureFieldModel.self)
  }
}