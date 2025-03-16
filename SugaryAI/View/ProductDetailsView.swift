import SwiftUI

struct ProductDetailsView: View {
    @State private var productImageWidth: CGFloat = 220
    @State private var productImageHeight: CGFloat = 220
    @State private var productImageOffsetX: CGFloat = 0
    @State private var productImageOffsetY: CGFloat = 0
    
    @State private var badgeWidth: CGFloat = 85
    @State private var badgeHeight: CGFloat = 90
    @State private var badgeOffsetX: CGFloat = 0
    @State private var badgeOffsetY: CGFloat = 0
    
    @State private var product = Product(
        name: "Banana",
        company: "Tropical Harvest",
        calories: 105,
        servings: 1,
        glycemicLoadValue: 14, // Medium GL
        sugar: 14,
        protein: 1,
        fat: 0,
        carbs: 27,
        image: "banana_image"
    )
    
    @State private var isEditing = false
    @State private var tempName = "Product Name"
    @State private var tempCompany = "Company name"
    @State private var showInfo = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 12) {
//                    // MARK: - Top Navigation Bar
//                    HStack {
//                        Spacer()
//                        Text("Beans")
//                            .font(.system(size: 20, weight: .bold))
//                        Spacer()
//                  
//                    }
//                    .padding(.horizontal, 20)
//                    .padding(.top, -30)
                    
                    // Separator Line
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 1)
                        .padding(.horizontal)
                    
                    // MARK: - Product Image
                    Image("item.image")
                        .resizable()
                        .scaledToFit()
                        .frame(width: productImageWidth, height: productImageHeight)
                        .cornerRadius(10)
                        .offset(x: productImageOffsetX, y: productImageOffsetY)
                    
                    // MARK: - Product Info Section
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(alignment: .top) {
                            if isEditing {
                                TextField("Product Name", text: $tempName)
                                    .font(.system(size: 22, weight: .bold))
                                    .padding(10)
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
                            } else {
                                Text(product.name)
                                    .font(.system(size: 22, weight: .bold))
                            }
                            Spacer()
                            VStack(alignment: .trailing, spacing: 2) {
                                Text("\(product.calories)")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(Color.accentColor)
                                    .padding(.bottom, 9)
                                Text("Cal")
                                    .font(.system(size: 17, weight: .medium))
                                    .foregroundColor(Color.black)
                            }
                        }

                        if isEditing {
                            TextField("Company name", text: $tempCompany)
                                .font(.system(size: 16))
                                .padding()
                                .background(Color.white)
                                .cornerRadius(8)
                                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 5)
                        } else {
                            Text(product.company)
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal, 28)

                    Divider()

                    // MARK: - Serving Control
                    HStack {
                        Text("Number of serving")
                            .font(.system(size: 20, weight: .bold))
                        Spacer()
                        HStack(spacing: 24) {
                            Button(action: {
                                if product.servings > 1 { product.servings -= 1 }
                            }) {
                                Image(systemName: "minus")
                                    .foregroundColor(.black)
                            }
                            Text("\(product.servings)")
                                .font(.system(size: 20, weight: .medium))
                            Button(action: {
                                product.servings += 1
                            }) {
                                Image(systemName: "plus")
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                    }
                    .padding(.horizontal, 28)

                    Divider()
                    
                    // MARK: - Glycemic Load Indicator
                    ZStack(alignment: .topTrailing) {
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Glycemic Load")
                                    .font(.system(size: 18, weight: .bold))
                                Text(product.glycemicLoadText)
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(product.glycemicLevelColor)
                            }
                            Spacer()
                            ZStack {
                                Image("glycemic_indicator")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 160, height: 88)
                                
                                Image("glycemic_pointer")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 40)
                                    .offset(x: 1, y: 19)
                            }
                        }
                        .frame(width: 320, height: 85)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                        
                        // Info button
                        Button(action: {
                            withAnimation {
                                showInfo.toggle()
                            }
                        }) {
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(Color("bluePurple"))
                        }
                        .padding([.top, .trailing], 12)
                    }
                    
                    // MARK: - Nutritional Values
                    HStack(spacing: 8) {
                        NutritionalValueBadge(icon: "memoji_sugar", value: "\(product.sugar)g", label: "Sugar", width: 80, height: 80, offsetX: 0, offsetY: 10)
                        NutritionalValueBadge(icon: "memoji_protein", value: "\(product.protein)g", label: "Protein", width: 80, height: 80, offsetX: 0, offsetY: 10)
                        NutritionalValueBadge(icon: "memoji_fat", value: "\(product.fat)g", label: "Fat", width: 80, height: 80, offsetX: 0, offsetY: 10)
                        NutritionalValueBadge(icon: "memoji_carbs", value: "\(product.carbs)g", label: "Carbs", width: 80, height: 80, offsetX: 0, offsetY: 10)
                    }
                    .padding(.horizontal)
                    
                    Spacer(minLength: 80)
                }
                .padding(.top, 10)
                .padding(.bottom, 2)
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing)
                {
                    Button(action: {
                        if isEditing {
                            product.name = tempName
                            product.company = tempCompany
                        } else {
                            tempName = product.name
                            tempCompany = product.company
                        }
                        isEditing.toggle()
                    }) {
                        Text(isEditing ? "Save" : "Edit")
                            .foregroundColor(Color.blue)
                    }
                }
                
//                ToolbarItem(placement: .bottomBar){
//                    // MARK: - Bottom Tab Bar
//                    BottomTabBar()
//                }
            }
            // 2️⃣ Always fixed tab bar
//              VStack {
//                  Spacer()
//                  BottomTabBar()
//              }
//           
            
             //   .padding(.bottom, -7)
            
            // MARK: - Info Bubble
            if showInfo {
                VStack {
                    Spacer().frame(height: 360)
                    HStack {
                        Spacer()
                        Text("It is a measure of how much food raises your blood sugar! The higher it is, the faster the effect!")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.black)
                            .padding()
                            .background(Color("Color"))
                            .cornerRadius(10)
                            .frame(width: 250)
                            .padding(.top, -400)
                        Spacer()
                    }
                }
            }
        }.navigationTitle("Beans")
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea(.keyboard, edges: .bottom) // 🔥 IMPORTANT 🔥



    }
}

// MARK: - Preview
struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView()
    }
}
