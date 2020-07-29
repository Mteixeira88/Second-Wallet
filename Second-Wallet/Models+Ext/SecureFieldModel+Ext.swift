import Foundation

extension SecureFieldModel: Identifiable, Equatable, Hashable {
    public static func == (lhs: SecureFieldModel, rhs: SecureFieldModel) -> Bool {
        lhs.id == rhs.id
            && lhs.cardId == rhs.cardId
            && lhs.title == rhs.title
            && lhs.value == rhs.value
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id + cardId)
    }
}
