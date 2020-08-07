import SwiftUI

enum SFSymbols: String {
    case magnifyGlass = "magnifyingglass"
    case magnifyGlassMinus = "minus.magnifyingglass"
    case magnifyGlassPlus = "plus.magnifyingglass"
    
    case plus = "plus"
    case minus = "minus"
    
    case locker = "lock.fill"
    case lockerOpen = "lock.open.fill"
    
    case xmark = "xmark.circle.fill"
}

enum Colors: String {
    case brand = "brand"
    case inputBackground = "inputBackground"
    case inputError = "inputError"
    case inputErrorLabel = "inputErrorLabel"
}

enum Assets {
    static func systemIcon(_ symbol: SFSymbols) -> Image {
        return Image(systemName: symbol.rawValue)
    }
    
    static func colors(_ color: Colors) -> Color {
        return Color(color.rawValue)
    }
}
