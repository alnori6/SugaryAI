import SwiftUI

struct PantryView: View {
    @StateObject var viewModel = PantryViewModel()
    @State private var searchText = ""
    
    @State private var selectedProduct: Product?
    @State private var selectedFilter: GlycemicLoad = .low // Default filter

    // ✅ State variables to track filter and history button clicks
   @State private var showFilterSheet = false
   @State private var showHistorySheet = false
    
    @State private var showDeleteConfirmation = false
    @State private var selectedIndexSet: IndexSet?

    func deleteItem(at offsets: IndexSet) {
        viewModel.items.remove(atOffsets: offsets)
    }

    var body: some View {
        NavigationStack {
            
            //MARK: - Show "Recently Scanned" when history is active
            //MARK: - WILL WORK ON IT SOON
//            if showHistorySheet {
//                VStack(alignment: .leading, spacing: 8) {
//                    Text("RECENTLY SCANNED")
//                        .font(.system(size: 14, weight: .bold))
//                        .foregroundColor(.gray)
//                        .padding(.horizontal, 16)
//                    
//                    ForEach(viewModel.recentlyScanned) { item in
//                        PantryCard(item: item)
//                            .padding(.horizontal, 16)
//                    }
//                }
//            }
            
            
            List {
                ForEach(viewModel.filteredItems(searchText, filter: selectedFilter)) { item in
                    Button(action: {
                        selectedProduct = item // Set selected item
                    }) {
                        PantryCard(item: item)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .listRowSeparator(.hidden)
                }
                .onDelete { offsets in
                    selectedIndexSet = offsets
                    showDeleteConfirmation = true
                }
            }
            .listStyle(.plain)
            .listRowInsets(EdgeInsets(top: 8, leading: 4, bottom: 4, trailing: 4))
            .searchable(text: $searchText, prompt: "Search")
            .navigationDestination(item: $selectedProduct) { product in
                ProductDetailsView(product: product)
            }
            // Present Filter View
            .sheet(isPresented: $showFilterSheet) {
                FilterView(selectedFilter: $selectedFilter) // Bind selectedFilter here
                    .presentationDetents([.fraction(0.5)]) // Half-screen height
                    .presentationDragIndicator(.visible)
            }
            .actionSheet(isPresented: $showDeleteConfirmation, content: {
                ActionSheet(title: Text("Are you sure you want to delete this item?\nThis action cannot be undone."), buttons: [
                    .destructive(Text("Delete"), action: {
                        if let indexSet = selectedIndexSet {
                            deleteItem(at: indexSet)
                        }
                    }),
                    .cancel()
                ])
            })
            .toolbar{
                ToolbarItem(placement: .principal) {
                    Text("Pantry")
                        .font(.system(size: 17, weight: .semibold))
                        
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                       showFilterSheet.toggle()
                   }) {
                       Image(systemName: showFilterSheet ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
                           .font(.system(size: 17, weight: .medium))
                           .foregroundColor(Color.accentColor)
                           
                   }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                       showHistorySheet.toggle()
                   }) {
                       Image(systemName: showHistorySheet ? "clock.fill" : "clock")
                          .font(.system(size: 17, weight: .medium))
                          
                          
                   }
                }
            }
            .toolbarBackground(.ultraThinMaterial)
        }
        
    }
}

// MARK: - Preview
#Preview {
    PantryView()
}
        

