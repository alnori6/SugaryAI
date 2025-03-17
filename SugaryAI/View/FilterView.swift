//
//  FilterView.swift
//  SugaryAI
//
//  Created by Noori on 16/03/2025.
//

import SwiftUI

struct FilterView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var selectedFilter: GlycemicLoad // Use a binding to pass the value back

    
    var body: some View {
        NavigationView {
            
            
            VStack(spacing: 16) {
                // MARK: - Filter Options
                List {
                    Section(header: Text("INCLUDE")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                        .padding(.top, 4)
                    ) {
                        ForEach(GlycemicLoad.allCases, id: \.self) { filter in
                            HStack {
                                //                                Label(filter.label, systemImage: "flag.fill")
                                Image(systemName: "flag.fill")
                                    .foregroundColor(filter.color)
                                
                                Text("\(filter.label) GL")
                                
                                Spacer()
                                if selectedFilter == filter {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.accentColor)
                                }
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                selectedFilter = filter
                            }
                        }
                    }
                    .listRowBackground(Color(.systemGray6))
                }
                .scrollContentBackground(.hidden) // ✅ Hide default background
                
            }
            .navigationTitle("Filter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        // call the func to implement the
                        dismiss()
                    }){
                        Text("Done")
                            .foregroundColor(Color.accentColor)
                    }
                }
            }
        }
        
        
        
        
        
    }
}

//#Preview {
//    FilterView()
//}
