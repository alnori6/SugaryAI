import SwiftUI
import Foundation
import SwiftData


struct Item: Identifiable {
    var id = UUID()
//    var name: String
//    var companyName: String
//    var protien: Double
//    var carbohydrates: Double
//    var fat: Double
//    var calories: Double
//    var glaycemicLoad: Double
    var productImage: UIImage?
    init(id: UUID = UUID(), productImage: UIImage? = nil) {
        self.id = id
        self.productImage = productImage
    }

    
}

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
//struct Product: Identifiable, Hashable {
//    let id: UUID = UUID()
//    var name: String
//    var company: String
//    var calories: Int
//    var servingSize: Int
//    let glycemicIndexValue: Int // important
//    var sugar: Int
//    var protein: Int
//    var fat: Int
//    var carbs: Int
//    let image: String
//    
//    /// ✅ Computed property for glycemic load category (instead of storing text)
//    var glycemicLoad: GlycemicLoad {
//        GlycemicLoad.from(value: glycemicIndexValue)
//    }
//
//    /// ✅ UI-Friendly Computed Properties
//    var glycemicLoadText: String { glycemicLoad.label }
//    var glycemicLevelColor: Color { glycemicLoad.color }
//}


struct Product: Identifiable, Hashable {
    let id: UUID = UUID()
    var name: String
    var company: String
    var calories: Int
    var servingSize: Int
    let glycemicIndexValue: Int // ✅ Important for GL Calculation
    var sugar: Int
    var protein: Int
    var fat: Int
    var carbs: Int
    let image: String
    
    /// ✅ Computed property for Glycemic Load calculation
    var glycemicLoadValue: Int {
        calculateGlycemicLoad(glycemicIndexValue: glycemicIndexValue, carbs: Double(carbs))
    }

    /// ✅ Computed property for glycemic load category (instead of storing text)
    var glycemicLoad: GlycemicLoad {
        GlycemicLoad.from(value: glycemicLoadValue)
    }

    /// ✅ UI-Friendly Computed Properties
    var glycemicLoadText: String { glycemicLoad.label }
    var glycemicLevelColor: Color { glycemicLoad.color }
    
    /// ✅ Function to calculate Glycemic Load
    func calculateGlycemicLoad(glycemicIndexValue: Int, carbs: Double) -> Int {
        let glycemicLoad = (Double(glycemicIndexValue) * carbs) / 100.0
        return Int(round(glycemicLoad)) // ✅ Round to the nearest whole number
    }
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
        case 20...: return .veryHigh  // 🔥 GL ≥ 20 → Very High
        case 11...19: return .high    // 🔥 GL 11-19 → High
        case 8...10: return .medium   // 🟡 GL 8-10 → Medium
        default: return .low          // 🟢 GL 0-7 → Low
        }
    }
    
}
