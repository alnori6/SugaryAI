import SwiftUI

enum GlycemicLoad {
    case veryHigh, high, medium, low
    
    var color: Color {
        switch self {
        case .veryHigh: return Color(hex: "#F15353")
        case .high: return Color(hex: "#FF6B6B")
        case .medium: return Color(hex: "#FF9A6C")
        case .low: return Color(hex: "#10B981")
        }
    }
}
