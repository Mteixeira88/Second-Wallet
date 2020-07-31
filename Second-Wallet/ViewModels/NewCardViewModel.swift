import SwiftUI

struct NewCardFormModel {
    var digitsIsEnable: Bool
    var digits: String
    var errorDigits: Bool
    var tag: String
    var errorTag: Bool
    var brand: String
    var errorBrand: Bool
    var backgroundColor: Color
    var secureFields: [SecureFieldsViewModel]
}

struct SecureFieldsViewModel {
    var id: String
    var title: String
    var value: String
    var error: Bool
    
    init() {
        self.id = UUID().uuidString
        self.title = ""
        self.value = ""
        self.error = false
    }
}

class NewCardViewModel: ObservableObject {
    @Published var formModel: NewCardFormModel
    
    init() {
        formModel = NewCardFormModel(
            digitsIsEnable: true,
            digits: "",
            errorDigits: false,
            tag: "",
            errorTag: false,
            brand: "",
            errorBrand: false,
            backgroundColor: Color.red,
            secureFields: [SecureFieldsViewModel()]
        )
    }
    
    func resetForm() {
        formModel = NewCardFormModel(
            digitsIsEnable: true,
            digits: "",
            errorDigits: false,
            tag: "",
            errorTag: false,
            brand: "",
            errorBrand: false,
            backgroundColor: Color.red,
            secureFields: [SecureFieldsViewModel()]
        )
    }
    
    func resetErrors() {
        formModel.errorDigits = false
        formModel.errorTag = false
        formModel.errorTag = false
    }
    
    func validateForm() -> Bool {
        resetErrors()
        if formModel.digitsIsEnable,
           (formModel.digits.trimmingCharacters(in: .whitespaces).isEmpty ||
        formModel.digits.trimmingCharacters(in: .whitespaces).count != 4) {
            formModel.errorDigits = true
        }
        
        if formModel.tag.trimmingCharacters(in: .whitespaces).isEmpty {
            formModel.errorTag = true
        }
        
        if formModel.brand.trimmingCharacters(in: .whitespaces).isEmpty {
            formModel.errorBrand = true
        }
        
        let errorSecure = formModel.secureFields.filter({
            $0.title.trimmingCharacters(in: .whitespaces).isEmpty ||
            $0.value.trimmingCharacters(in: .whitespaces).isEmpty
        })
        
        if !errorSecure.isEmpty {
            errorSecure.forEach { (error) in
                guard let index = formModel.secureFields.firstIndex(where: { $0.id == error.id }) else {
                    return
                }
                formModel.secureFields[index].error = true
            }
        }
        
        if formModel.errorDigits ||
            formModel.errorBrand ||
            formModel.errorTag ||
            !errorSecure.isEmpty {
            return false
        }
        
        return true
    }
    
    func createCard() -> CardModel {
        let backgroundColor = UIColor(formModel.backgroundColor).toHexString()
        return CardModel(
            digits: formModel.digitsIsEnable ? formModel.digits : nil,
            tag: formModel.tag,
            brand: formModel.brand,
            backgroundColor: backgroundColor
        )
    }
    
    func createSecureFieds() -> [SecureFieldModel] {
        var secureFields = [SecureFieldModel]()
        formModel.secureFields.forEach { (secure) in
            secureFields.append(SecureFieldModel(title: secure.title, value: secure.value))
        }
        return secureFields
    }
}
