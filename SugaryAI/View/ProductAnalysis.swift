//
//  ProductAnalysisSheet.swift
//  SugaryAI
//
//  Created by Shatha Almukhaild on 17/09/1446 AH.
//

import SwiftUI

struct ProductAnalysis: View {
    @Environment(\.dismiss) var dismiss
    @State private var serving: Int = 1
    @State private var showInfo = false
    @State private var saveItemToPantry = false
    

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
//
    var body: some View {
        NavigationView {
            
            
            ScrollView {
                VStack(spacing: 16) {
                    // MARK: - Product Analysis
                    
                    //MARK: - product name and company + calorise
                    HStack(){
                        VStack(alignment: .leading, spacing: 8){
                            Text(product.name)
                                .font(.system(size: 24, weight: .bold))
                            
                            Text(product.company)
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
                                Text("Serving of \(product.servingSize)g size")
                                    .font(.system(size: 16))
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                        Stepper("", value: $serving, in: 1...100)
                    }// end hstack
                    ////
                    Divider()
                    HStack{
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
                             
//                            .help("It is a measure of how much food raises your blood sugar! The higher it is, the faster the effect!")
//                                                .popover(isPresented: $showInfo) {
//                                                    Text("It is a measure of how much food raises your blood sugar! The higher it is, the faster the effect.")
//                                                        .padding()
//                                                        .frame(width: 300, height: 100)
//                                                }
                            //                            .popover(isPresented: $showInfo, attachmentAnchor: .point(.bottom), arrowEdge: .top) {
                            //                                Text("It is a measure of how much food raises your blood sugar! The higher it is, the faster the effect!")
                            //                            }
                            //  Spacer()
                        }
                        
                    }.padding(.trailing)
                    // Display Bubble Tip near Info Button
                              BubbleTip(text: "It is a measure of how much food raises your blood sugar!", isVisible: showInfo)
                                  .frame(maxWidth: .infinity, alignment: .center)
                                  //.padding(.top, 20)


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
                            //                                .rotationEffect(Angle(degrees: glycemicRotationAngle()), anchor: .bottom)
                        }
                        
                        Spacer()
                        
                    }
                    //                .padding()
                    //                .background(Color(.systemBackground))
                    //                .cornerRadius(16)
                    //                .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 3)
                    
                    Divider()
                    
                    // MARK: - Nutritional Values
                    HStack() {
                        NutritionalValueBadge(icon: "🍫", value: "\(product.sugar)g", label: "Sugar")
                        Spacer()
                        NutritionalValueBadge(icon: "🥩", value: "\(product.protein)g", label: "Protein")
                        Spacer()
                        NutritionalValueBadge(icon: "🧈", value: "\(product.fat)g", label: "Fat")
                        Spacer()
                        NutritionalValueBadge(icon: "🍞", value: "\(product.carbs)g", label: "Carbs")
                    }
                    .frame(maxWidth:.infinity)
                    .padding(16)
                    Button {
                        saveItemToPantry = true
                        // Action here
                    } label: {
                        Label("Save the item", systemImage: saveItemToPantry ? "bookmark.fill": "bookmark")
                    }
                    .buttonStyle(SecondaryButton())             //   Spacer()
                    
                    
                    
                }// End of VStack
           
                .frame(maxHeight: .infinity, alignment: .top) // Push content up
                .padding()
            }
   
        }// End of Navigation View
        
        
        
        
        
    }// End of Body

}
struct BubbleTip: View {
    var text: String
    var isVisible: Bool
    
    var body: some View {
        VStack {
            if isVisible {
                ZStack {
     
                    // Text inside the bubble
                    Text(text)
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                        .padding(8)
                        .background(Color.lightPurple)
                        .cornerRadius(8)
                        //.shadow(radius: 5)
                        .padding(.trailing, 10) // Space between bubble and triangle
                    // Triangle (behind the text)
                    Triangle()
                        .fill(Color.lightPurple)
                        .frame(width: 10, height: 10)
                        .rotationEffect(.degrees(0)) // Rotate to point downwards
                       // .offset(y: 10) // Position the triangle beneath the bubble
                        .padding(.bottom,55)
                        .padding(.leading,250)
                }
                .padding(.leading,55)// Position the whole bubble tip above the button
                .transition(.opacity) // Fade in/out effect
            }
        }
    }
}

// Custom Triangle Shape for Bubble Tip Arrow
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY)) // Top of the triangle
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY)) // Bottom left
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY)) // Bottom right
        path.closeSubpath()
        return path
    }
}

#Preview {
    ProductAnalysis(product:  Product(name: "Bread", company: "Lusine", calories: 79, servingSize: 1, glycemicLoadValue: 12, sugar: 1, protein: 3, fat: 1, carbs: 15, image: "Bread"))
}
