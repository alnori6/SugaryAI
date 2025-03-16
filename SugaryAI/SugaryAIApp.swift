//
//  SugaryAIApp.swift
//  SugaryAI
//
//  Created by Noori on 13/03/2025.
//

import SwiftUI

@main
struct SugaryAIApp: App {
    
//    init() {
//        UITabBar.appearance().tintColor = UIColor(named: "AccentColor") // Force correct accent color
//    }
//    
    var body: some Scene {
        WindowGroup {
            BottomTabBar(selectedTab: .pantry)
                .accentColor(Color.accent) // Set SwiftUI global accent color
                .fontDesign(.rounded)
                
        }
    }
}

#Preview {
    
}

