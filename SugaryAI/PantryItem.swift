import SwiftUI

struct PantryItem: Identifiable {
    let id = UUID()
    let name: String
    let carbs: String
    let calories: String
    let glycemicLoad: GlycemicLoad
    let image: String
}
