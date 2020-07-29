// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "c640f298e196726ba56525cb5284c4fc"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: CardModel.self)
    ModelRegistry.register(modelType: SecureFieldModel.self)
  }
}