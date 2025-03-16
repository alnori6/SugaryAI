import SwiftUI

struct NutritionalValueBadge: View {
    let icon: String
    let value: String
    let label: String
    
    var body: some View {
        
        VStack(spacing: 4) {
            Text(icon)
                .font(.system(size: 20))
            
            Text(value)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(Color.blue)
            
            Text(label)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(Color.gray)
            
        }
        .background(
            Image("nutritional_badge")
                .resizable()
                .scaledToFit()
                .frame(width: 84, height: 90)
        )
        
    }
}



#Preview {
    NutritionalValueBadge(
        icon: "🍫",
        value: "15g",
        label: "Sugar"
    )
}
