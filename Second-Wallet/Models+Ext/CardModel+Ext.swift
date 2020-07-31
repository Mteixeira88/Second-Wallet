import Foundation

extension CardModel: Identifiable, Equatable, Hashable {
    public static func ==(lhs: CardModel, rhs: CardModel) -> Bool {
        lhs.id == rhs.id
            && lhs.brand == rhs.brand
            && lhs.backgroundColor == rhs.backgroundColor
            && lhs.digits == rhs.digits
            && lhs.lastOpen == rhs.lastOpen
            && lhs.tag == rhs.tag
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
