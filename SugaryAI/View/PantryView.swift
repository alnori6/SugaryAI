import SwiftUI

struct PantryView: View {
    @StateObject var viewModel = PantryViewModel()
    @State private var searchText = ""

    let pagePadding: CGFloat = 15
    let cardSpacing: CGFloat = 16
    let cardWidth: CGFloat = 300
    let cardHeight: CGFloat = 98

    var body: some View {
      //  NavigationView {
             // Color.clear.frame(height: 1) // <-- invisible fix spacer

            ZStack {
                VStack(spacing: 0) {
                    // ✅ FIX: Add this to remove extra spacing under navigation bar
                                //  Color.clear.frame(height: 1) // <-- invisible fix spacer
                    // MARK: - Search Bar
                    VStack(spacing: 0) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            TextField("Search", text: $searchText)
                                .foregroundColor(.black)
                            Image(systemName: "mic.fill")
                                .foregroundColor(.gray)
                        }
                        .padding(8)
                        .background(Color("Color"))
                        .cornerRadius(8)
                        .padding(.horizontal, pagePadding)

                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 1)
                            .padding(.horizontal, pagePadding)
                            .padding(.top, 8)
                    }
                    .padding(.top, 4) // ✅ Clean small top padding instead of negative values

                    //.padding(.top, -8) // ✅ Reduce space below Nav Bar


                    // MARK: - Scrollable Cards
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: cardSpacing) {
                            ForEach(viewModel.filteredItems(searchText), id: \.id) { item in
                                NavigationLink(destination: ProductDetailsView()) {
                                    SwipeToDeleteCard(
                                        item: item,
                                        items: $viewModel.items,
                                        cardWidth: cardWidth,
                                        cardHeight: cardHeight
                                    )
                                }
                                .padding(.horizontal, pagePadding)
                                .offset(x: 10)
                            }
                        }
                        .padding(.top, cardSpacing)
                        .padding(.bottom, 100) // extra space for tab bar
                    }
                    .padding(.top, -10) // ✅ Minimal negative padding works best

                }

                // MARK: - Fixed Bottom Tab Bar
//                VStack {
//                    Spacer()
//                    BottomTabBar()
//                }
            }
            .background(Color.white)
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .navigationTitle("Pantry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {}) {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(Color("purple1"))
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "clock")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(Color("purple1"))
                    }
                }
            }
     //   }
    }
}

// MARK: - Preview
#Preview {
    PantryView()
}
        

