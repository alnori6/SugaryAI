import SwiftUI

class PantryViewModel: ObservableObject {
    @Published var items: [Product] = [
           // ✅ Grains & Legumes
           Product(name: "Beans", company: "Healthy Co", calories: 230, servingSize: 1, glycemicLoadValue: 22, sugar: 5, protein: 15, fat: 1, carbs: 37, image: "item.image"),
           Product(name: "Rice", company: "Farm Fresh", calories: 210, servingSize: 1, glycemicLoadValue: 18, sugar: 0, protein: 4, fat: 1, carbs: 50, image: "item.image"),
           Product(name: "Bread", company: "Baker's Delight", calories: 200, servingSize: 2, glycemicLoadValue: 12, sugar: 3, protein: 6, fat: 2, carbs: 40, image: "item.image"),
           Product(name: "Pasta", company: "Italian Goodies", calories: 250, servingSize: 1, glycemicLoadValue: 8, sugar: 2, protein: 8, fat: 1, carbs: 55, image: "item.image"),
           Product(name: "Oats", company: "Healthy Grains", calories: 190, servingSize: 1, glycemicLoadValue: 6, sugar: 1, protein: 5, fat: 3, carbs: 30, image: "item.image"),
           Product(name: "Quinoa", company: "Organic Harvest", calories: 222, servingSize: 1, glycemicLoadValue: 7, sugar: 1, protein: 8, fat: 2, carbs: 39, image: "item.image"),
           Product(name: "Lentils", company: "NutriSource", calories: 180, servingSize: 1, glycemicLoadValue: 13, sugar: 2, protein: 12, fat: 1, carbs: 35, image: "item.image"),

           // ✅ Vegetables
           Product(name: "Sweet Potatoes", company: "Green Farms", calories: 200, servingSize: 1, glycemicLoadValue: 14, sugar: 7, protein: 2, fat: 0, carbs: 42, image: "item.image"),
           Product(name: "Potatoes", company: "Root Harvest", calories: 280, servingSize: 1, glycemicLoadValue: 25, sugar: 2, protein: 4, fat: 1, carbs: 60, image: "item.image"),
           Product(name: "Carrots", company: "Farm Fresh", calories: 50, servingSize: 1, glycemicLoadValue: 5, sugar: 4, protein: 1, fat: 0, carbs: 12, image: "item.image"),
           Product(name: "Corn", company: "Golden Fields", calories: 220, servingSize: 1, glycemicLoadValue: 17, sugar: 6, protein: 4, fat: 2, carbs: 45, image: "item.image"),
           Product(name: "Spinach", company: "Organic Greens", calories: 23, servingSize: 1, glycemicLoadValue: 1, sugar: 0, protein: 3, fat: 0, carbs: 3, image: "item.image"),
           
           // ✅ Fruits
           Product(name: "Apples", company: "Nature's Best", calories: 80, servingSize: 1, glycemicLoadValue: 6, sugar: 19, protein: 0, fat: 0, carbs: 22, image: "item.image"),
           Product(name: "Bananas", company: "Tropical Harvest", calories: 105, servingSize: 1, glycemicLoadValue: 14, sugar: 14, protein: 1, fat: 0, carbs: 27, image: "item.image"),
           Product(name: "Grapes", company: "Vineyard Select", calories: 104, servingSize: 1, glycemicLoadValue: 11, sugar: 23, protein: 1, fat: 0, carbs: 27, image: "item.image"),
           Product(name: "Mango", company: "Tropical Delights", calories: 150, servingSize: 1, glycemicLoadValue: 10, sugar: 31, protein: 1, fat: 0, carbs: 35, image: "item.image"),
           Product(name: "Blueberries", company: "Berry Fresh", calories: 57, servingSize: 1, glycemicLoadValue: 5, sugar: 10, protein: 1, fat: 0, carbs: 14, image: "item.image"),
           
       ]

    func filteredItems(_ searchText: String) -> [Product] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    // MARK: - Calculate Glycemic Load
    func calculateGlycemicLoad(glycemicIndex: Int, carbs: Double) -> Int {
        let glycemicLoad = (Double(glycemicIndex) * carbs) / 100.0
        return Int(round(glycemicLoad)) // ✅ Round to the nearest whole number
    }
    
    
    
    
    
    
    
}
