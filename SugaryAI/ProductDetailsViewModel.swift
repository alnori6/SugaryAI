import SwiftUI

class ProductDetailsViewModel: ObservableObject {
    @Published var product: Product = Product(
        name: "Product Name",
        company: "Company name",
        calories: 500,
        servings: 2,
        glycemicLoadText: "Contains High GL",
        glycemicLevelColor: .red,
        sugar: "2g",
        protein: "7g",
        fat: "1g",
        carbs: "50g"
    )
    
    @Published var isEditing = false
    @Published var tempName = ""
    @Published var tempCompany = ""
    @Published var showInfo = false
    
    init() {
        tempName = product.name
        tempCompany = product.company
    }
    
    func toggleEdit() {
        if isEditing {
            product.name = tempName
            product.company = tempCompany
        } else {
            tempName = product.name
            tempCompany = product.company
        }
        isEditing.toggle()
    }
    
    func increaseServings() {
        product.servings += 1
    }
    
    func decreaseServings() {
        if product.servings > 1 {
            product.servings -= 1
        }
    }
}
