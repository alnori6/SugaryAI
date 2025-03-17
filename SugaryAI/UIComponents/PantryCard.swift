//
//  PantryCard.swift
//  SugaryAI
//
//  Created by Noori on 15/03/2025.
//


import SwiftUI

struct PantryCard: View {
    
    let item: Product
    
    var body: some View {
        
                // ✅ Main Card Background
                HStack(spacing: 16) {
                    // ✅ Left Side Glycemic Indicator
                    Rectangle()
                        .fill(Color(item.glycemicLevelColor)) // ✅ Matches the provided image
                        .clipShape(RoundedCornerShape(corners: [.topLeft, .bottomLeft], radius: 20))
                        .frame(width: 30) // ✅ Thicker for better visibility
                        .padding(.vertical, -16) // ✅ Matches padding on top & bottom
                        .padding(.leading, -16) // ✅ Aligns the rectangle to the card edge
                    
                    // ✅ Product Image
                    Image(item.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 6))

                    VStack(alignment: .leading, spacing: 24) {
                        // ✅ Product Name
                        Text(item.name)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color("purple1")) // Matches the image

                        // ✅ Nutritional Info
                        HStack(spacing: 24) {
                            Text("🍞 \(item.carbs)g \nCarbs")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(Color("grayText"))
                                .multilineTextAlignment(.center)
                                .lineSpacing(3)
                            
                            Text("🔥 \(item.calories) \nCalories")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(Color("grayText"))
                                .multilineTextAlignment(.center)
                                .lineSpacing(3)
                        }
                    }
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 65)
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 4)

        
        
    }
    
    struct RoundedCornerShape: Shape {
        var corners: UIRectCorner
        var radius: CGFloat

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(
                roundedRect: rect,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius)
            )
            return Path(path.cgPath)
        }
    }
    
}



#Preview {
    PantryCard(
        item: Product(
            name: "Banana",
            company: "Tropical Harvest",
            calories: 105,
            servingSize: 3,
            glycemicIndexValue: 14, // Medium GL
            sugar: 14,
            protein: 1,
            fat: 10,
            carbs: 127,
            image: "item.image"

        )
    )
   
}
