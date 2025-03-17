import SwiftUI

class PantryViewModel: ObservableObject {
    @Published var items: [Product] = [
           // ✅ Grains & Legumes
      
           Product(name: "Rice", company: "Q organics", calories: 340, servingSize: 1, glycemicLoadValue: 18, sugar: 0, protein: 6, fat: 1, carbs: 77, image: "Rice"),
           Product(name: "Bread", company: "Lusine", calories: 79, servingSize: 1, glycemicLoadValue: 12, sugar: 1, protein: 3, fat: 1, carbs: 15, image: "Bread"),
           Product(name: "Pasta", company: "AL-Joud", calories: 348, servingSize: 1, glycemicLoadValue: 8, sugar: 2, protein: 8, fat: 1, carbs: 55, image: "Pasta"),
           Product(name: "Custard Powder", company: "Healthy Grains", calories: 190, servingSize: 1, glycemicLoadValue: 6, sugar: 1, protein: 5, fat: 3, carbs: 30, image: "CustardPowder"),
           Product(name: "Milk", company: "Saudia", calories: 222, servingSize: 1, glycemicLoadValue: 7, sugar: 1, protein: 8, fat: 2, carbs: 39, image: "Milk"),

           
           
       ]

    // Update the filteredItems function to handle both search text and selected glycemic load filter
    func filteredItems(_ searchText: String, filter: GlycemicLoad) -> [Product] {
        let filteredByText = items.filter { item in
            searchText.isEmpty || item.name.localizedCaseInsensitiveContains(searchText)
        }

        let filteredByGlycemicLoad = filteredByText.filter { item in
            filter == .low || item.glycemicLoad == filter // Apply the glycemic load filter
        }

        return filteredByGlycemicLoad
    }
    
    // MARK: - Calculate Glycemic Load
    func calculateGlycemicLoad(glycemicIndex: Int, carbs: Double) -> Int {
        let glycemicLoad = (Double(glycemicIndex) * carbs) / 100.0
        return Int(round(glycemicLoad)) // ✅ Round to the nearest whole number
    }
    
    
    
    
    
    
    
}
