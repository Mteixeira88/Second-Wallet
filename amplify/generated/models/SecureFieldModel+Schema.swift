// swiftlint:disable all
import Amplify
import Foundation

extension SecureFieldModel {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case title
    case value
    case card
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let secureFieldModel = SecureFieldModel.keys
    
    model.pluralName = "SecureFieldModels"
    
    model.fields(
      .id(),
      .field(secureFieldModel.title, is: .required, ofType: .string),
      .field(secureFieldModel.value, is: .required, ofType: .string),
      .belongsTo(secureFieldModel.card, is: .optional, ofType: CardModel.self, targetName: "secureFieldModelCardId")
    )
    }
}