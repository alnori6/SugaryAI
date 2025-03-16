//
//  SwipeToDeleteCard.swift
//  SugaryAI
//
//  Created by Noori on 15/03/2025.
//


import SwiftUI

struct SwipeToDeleteCard: View {
    let item: Product
    @Binding var items: [Product]
    let cardWidth: CGFloat
    let cardHeight: CGFloat

    @State private var offset: CGFloat = 0
    @State private var isDeleted: Bool = false

    var body: some View {
        ZStack {
            HStack {
                Spacer()
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 70, height: cardHeight)
                    .cornerRadius(12)
                    .overlay(
                        VStack {
                            Image(systemName: "trash")
                                .foregroundColor(.white)
                                .font(.system(size: 22))
                            Text("Delete")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .bold))
                        }
                    )
            }
            .opacity(offset < -40 ? 1 : 0)

            PantryCard(item: item, cardWidth: cardWidth, cardHeight: cardHeight)
                .offset(x: offset)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            if gesture.translation.width < 0 {
                                offset = gesture.translation.width
                            }
                        }
                        .onEnded { _ in
                            if offset < -80 {
                                withAnimation {
                                    isDeleted = true
                                    items.removeAll { $0.id == item.id }
                                }
                            } else {
                                withAnimation {
                                    offset = 0
                                }
                            }
                        }
                )
        }
        .opacity(isDeleted ? 0 : 1)
    }
}


#Preview {
    @State var sampleItems: [Product] = [
        Product(name: "Banana", company: "Tropical Harvest", calories: 105, servings: 1, glycemicLoadValue: 14, sugar: 14, protein: 1, fat: 0, carbs: 27, image: "banana_image")
    ]
    
    return SwipeToDeleteCard(
        item: sampleItems[0],
        items: $sampleItems,
        cardWidth: 300,
        cardHeight: 150
    )
}
