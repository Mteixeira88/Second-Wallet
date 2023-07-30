// swiftlint:disable all
import Amplify
import Foundation

extension CardModel {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case digits
    case tag
    case brand
    case lastOpen
    case backgroundColor
    case secureFields
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let cardModel = CardModel.keys
    
    model.syncPluralName = "CardModels"
    
    model.fields(
      .id(),
      .field(cardModel.digits, is: .optional, ofType: .string),
      .field(cardModel.tag, is: .required, ofType: .string),
      .field(cardModel.brand, is: .required, ofType: .string),
      .field(cardModel.lastOpen, is: .optional, ofType: .string),
      .field(cardModel.backgroundColor, is: .required, ofType: .string),
      .hasMany(cardModel.secureFields, is: .optional, ofType: SecureFieldModel.self, associatedWith: SecureFieldModel.keys.card)
    )
    }
}
