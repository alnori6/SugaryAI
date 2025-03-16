//
//  MainTabView.swift
//  SugaryAI
//
//  Created by Noori on 16/03/2025.
//  Created by Raghad Mohammed Almarri on 10/09/1446 AH.
//


import SwiftUI


struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 0) {
                
                ZStack{
                    
                    Image("header")
                        .resizable()
                        .scaledToFill()
                        .frame( height: 200)
                        .overlay(
                            Color("AccentColor").opacity(0.3) // 🔥 Subtle Dark Overlay
                        )
                        .clipped()
                    
                    Image("main_logo")
                        .resizable()
                        .scaledToFit()
                        .frame( height: 158)
                }
                
                List {
                    Section(header: Text("MORE")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                        .padding(.top, 4)
                        .padding(.leading, -24)
                    ) {
                        ForEach(viewModel.options ){ option in
                            Button(action: {
                                viewModel.handleAction(option.actionType)
                            }) {
                                SettingsRow(icon: option.iconName, text: option.title)
                            }
                            
                        }
                        
                    }
                    
                }
                
                
            }// end vstack
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

// مكون لكل عنصر في القائمة
struct SettingsRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack {
            Text(text)
//                .foregroundColor(Color("purple1"))
            Spacer()
            Image(systemName: icon)
                .foregroundColor(.accent)
        }
        .padding(.vertical, 8)
    }
}


#Preview{
    SettingsView()
}
