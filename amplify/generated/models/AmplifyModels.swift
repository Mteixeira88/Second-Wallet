// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "2dceb5903a57815af1515aeb1e67c9d0"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: CardModel.self)
    ModelRegistry.register(modelType: SecureFieldModel.self)
  }
}