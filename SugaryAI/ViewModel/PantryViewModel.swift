import SwiftUI

class PantryViewModel: ObservableObject {
    @Published var items: [PantryItem] = [
        PantryItem(name: "Beans", carbs: "37g", calories: "230", glycemicLoad: .veryHigh, image: "beans_image"),
        PantryItem(name: "Rice", carbs: "50g", calories: "210", glycemicLoad: .high, image: "rice_image"),
        PantryItem(name: "Bread", carbs: "40g", calories: "200", glycemicLoad: .medium, image: "bread_image"),
        PantryItem(name: "Pasta", carbs: "55g", calories: "250", glycemicLoad: .low, image: "pasta_image"),
        PantryItem(name: "Oats", carbs: "30g", calories: "190", glycemicLoad: .low, image: "oats_image"),
        PantryItem(name: "Potatoes", carbs: "60g", calories: "280", glycemicLoad: .veryHigh, image: "potatoes_image"),
        PantryItem(name: "Corn", carbs: "45g", calories: "220", glycemicLoad: .high, image: "corn_image"),
        PantryItem(name: "Lentils", carbs: "35g", calories: "180", glycemicLoad: .medium, image: "lentils_image"),
        PantryItem(name: "Sweet Potatoes", carbs: "42g", calories: "200", glycemicLoad: .medium, image: "sweet_potatoes_image"),
        PantryItem(name: "Quinoa", carbs: "39g", calories: "222", glycemicLoad: .low, image: "quinoa_image")
    ]

    func filteredItems(_ searchText: String) -> [PantryItem] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
}
