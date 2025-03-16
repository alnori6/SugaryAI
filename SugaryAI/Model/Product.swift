import SwiftUI
import Foundation


//Raghad model
struct SettingsOption: Identifiable {
    let id = UUID()
    let title: String
    let iconName: String
    let actionType: SettingsAction
}

enum SettingsAction {
    case contactUs
    case rateUs
    case shareApp
}


// improved rasha model
struct Product: Identifiable, Hashable {
    let id: UUID = UUID()
    var name: String
    var company: String
    var calories: Int
    var servingSize: Int
    let glycemicLoadValue: Int // important
    var sugar: Int
    var protein: Int
    var fat: Int
    var carbs: Int
    let image: String
    
    /// ✅ Computed property for glycemic load category (instead of storing text)
    var glycemicLoad: GlycemicLoad {
        GlycemicLoad.from(value: glycemicLoadValue)
    }

    /// ✅ UI-Friendly Computed Properties
    var glycemicLoadText: String { glycemicLoad.label }
    var glycemicLevelColor: Color { glycemicLoad.color }
}


enum GlycemicLoad: Int, CaseIterable {
    case veryHigh = 4
    case high = 3
    case medium = 2
    case low = 1
    
    // Returns a color based on glycemic level
    var color: Color {
        switch self {
        case .veryHigh: return Color("deepRed")
        case .high: return Color("lightRed")
        case .medium: return Color("medium")
        case .low: return Color("greenLow")
        }
    }
    
    // Returns a readable text label
    var label: String {
        switch self {
        case .veryHigh: return "Very High"
        case .high: return "High"
        case .medium: return "Medium"
        case .low: return "Low"
        }
    }
    
    // Converts a numeric glycemic load value to an enum category
    static func from(value: Int) -> GlycemicLoad {
        switch value {
        case 21...: return .veryHigh // 🔥 21 and above → Very High
        case 15...20: return .high    // 🔥 15 to 20 → High
        case 8...14: return .medium   // 🟡 8 to 14 → Medium
        default: return .low          // 🟢 0 to 7 → Low
        }
    }
    
}
