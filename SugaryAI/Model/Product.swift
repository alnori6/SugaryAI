import SwiftUI

struct Product: Identifiable {
    let id: UUID = UUID()
    var name: String
    var company: String
    var calories: Int
    var servings: Int
    var glycemicLoadText: String
    var glycemicLevelColor: Color
    var sugar: String
    var protein: String
    var fat: String
    var carbs: String
}


struct PantryItem: Identifiable {
    let id = UUID()
    let name: String
    let carbs: String
    let calories: String
    let glycemicLoad: GlycemicLoad
    let image: String
}
