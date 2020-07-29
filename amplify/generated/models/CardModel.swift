// swiftlint:disable all
import Amplify
import Foundation

public struct CardModel: Model {
  public let id: String
  public var digits: Int?
  public var tag: String
  public var brand: String
  public var lastOpen: String?
  public var backgroundColor: String
  public var secureFields: List<SecureFieldModel>?
  
  public init(id: String = UUID().uuidString,
      digits: Int? = nil,
      tag: String,
      brand: String,
      lastOpen: String? = nil,
      backgroundColor: String,
      secureFields: List<SecureFieldModel> = []) {
      self.id = id
      self.digits = digits
      self.tag = tag
      self.brand = brand
      self.lastOpen = lastOpen
      self.backgroundColor = backgroundColor
      self.secureFields = secureFields
  }
}