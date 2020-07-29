// swiftlint:disable all
import Amplify
import Foundation

public struct SecureFieldModel: Model {
  public let id: String
  public var title: String
  public var value: String
  public var cardId: String
  
  public init(id: String = UUID().uuidString,
      title: String,
      value: String,
      cardId: String) {
      self.id = id
      self.title = title
      self.value = value
      self.cardId = cardId
  }
}