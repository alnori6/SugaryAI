import SwiftUI

struct ProductDetailsView: View {
    
    @State private var isEditing = false
    @State private var tempName = ""
    @State private var tempCompany = ""
    @State private var serving: Int = 1
    @State private var showInfo = false
    
    let product: Product
    
    // calculate the pointer movement
    func glycemicRotationAngle() -> Double {
        switch product.glycemicLoad {
        case .low: return -80  // Pointer shifts towards the green area
        case .medium: return -23  // Pointer stays neutral
        case .high: return 30  // Pointer shifts towards red
        case .veryHigh: return 90 // Pointer moves to extreme red
        }
    }

    var body: some View {
        
        var tempName = product.name
        var tempCompany = product.company
        
            ScrollView(){
                VStack(spacing: 24){
                    Image(product.image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    //MARK: - product name and company + calorise
                    HStack(){
                        VStack(alignment: .leading, spacing: 8){
                            Text(tempName)
                                .font(.system(size: 24, weight: .bold))
                            
                            Text(tempCompany)
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        
                        VStack(){
                            Text("\(product.calories)")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(Color.purple1)
                            
                            Text("Cal")
                                .font(.system(size: 17, weight: .medium))
                                .foregroundColor(Color.accentColor)
                        }
                    }// end hstack
                    
                    Divider()
                    
                    //MARK: - Number of Serving
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Number of Serving")
                                .font(.system(size: 20, weight: .medium))
                            HStack {
                                Text("\(serving)")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color.accentColor)
                                Text("Serving of \(product.servingSize)g")
                                    .font(.system(size: 16))
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                        Stepper("", value: $serving, in: 1...100)
                    }// end hstack
                    
                    Divider()
                    
                    // MARK: - Glycemic Load Indicator
                    HStack(){
                        
                        VStack(alignment: .leading, spacing: 8){
                            Text("Glycemic Load")
                                .font(.system(size: 20, weight: .bold))
                            
                            Text(product.glycemicLoadText)
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(product.glycemicLevelColor)
                            
                        }
                        
                        Spacer()
                        
                        ZStack {
                            Image("glycemic_indicator")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 160)

                            Image("glycemic_pointer")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .padding(.top, 30)
                                .rotationEffect(Angle(degrees: glycemicRotationAngle()), anchor: .bottom)
                                .animation(.spring(duration: 0.8), value: glycemicRotationAngle())
//                                .rotationEffect(Angle(degrees: glycemicRotationAngle()), anchor: .bottom)
                        }
                        
                        Spacer()
                        
                        VStack(){
                            Button(action: {
                                withAnimation{
                                    showInfo.toggle()
                                }
                            }){
                                Image(systemName: "info.circle.fill")
                                    .foregroundColor(Color("bluePurple"))
                            }
                            .help("It is a measure of how much food raises your blood sugar! The higher it is, the faster the effect!")
//                            .popover(isPresented: $showInfo, attachmentAnchor: .point(.bottom), arrowEdge: .top) {
//                                Text("It is a measure of how much food raises your blood sugar! The higher it is, the faster the effect!")
//                            }
                            Spacer()
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 3)
                    
                    Divider()
                    
                    // MARK: - Nutritional Values
                    HStack() {
                        NutritionalValueBadge(icon: "🍫", value: "\(product.sugar)g", label: "Sugar")
                        Spacer().frame(width: 55)
                       NutritionalValueBadge(icon: "🥩", value: "\(product.protein)g", label: "Protein")
                        Spacer().frame(width: 60)
                       NutritionalValueBadge(icon: "🧈", value: "\(product.fat)g", label: "Fat")
                        Spacer().frame(width: 64)
                       NutritionalValueBadge(icon: "🍞", value: "\(product.carbs)g", label: "Carbs")
                    }
                    .padding(16)
                    
                    Spacer()
                    
                    
                }// end big vstack
                .padding()
                .toolbar{
                    ToolbarItem(placement: .principal){
                        Text(product.name)
                            .font(.system(size: 17, weight: .medium))
                    }
                    ToolbarItem(placement: .topBarTrailing){
                        Button(action: {
                            isEditing.toggle()
                        }){
                            Text("Edit")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(Color.accentColor)
                        }
                    }
                    
                } // end toolbar
                .toolbarBackground(.ultraThinMaterial)
            }// end scroll view
            
                

            
            // MARK: - Info Bubble
//            if showInfo {
//                VStack {
//                    Spacer().frame(height: 360)
//                    HStack {
//                        Spacer()
//                        Text("It is a measure of how much food raises your blood sugar! The higher it is, the faster the effect!")
//                            .font(.system(size: 14, weight: .medium))
//                            .foregroundColor(.black)
//                            .padding()
//                            .background(Color("Color"))
//                            .cornerRadius(10)
//                            .frame(width: 250)
//                            .padding(.top, -400)
//                        Spacer()
//                    }
//                }
//            }
        


        

    }
}

// MARK: - Preview
#Preview {
    ProductDetailsView(product: Product(
        name: "Banana",
        company: "Tropical Harvest",
        calories: 105,
        servingSize: 66,
        glycemicIndexValue: 14,
        sugar: 14,
        protein: 1,
        fat: 0,
        carbs: 27,
        image: "item.image"
    ))
}
