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
    init() {
         UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.blue
         UIPageControl.appearance().pageIndicatorTintColor = UIColor.lightGray
         UIPageControl.appearance().backgroundStyle = .minimal
     }
    
    @AppStorage("hasSeenLandingPage") private var hasSeenLandingPage: Bool = false

    var body: some Scene {
        WindowGroup {
            // Check if the user has seen the landing page
                       if hasSeenLandingPage {
                           // Show the Main App with a fade-in transition
                           BottomTabBar(selectedTab: .scan)
                               .accentColor(Color.accent)
                               .fontDesign(.rounded)
                               .transition(.opacity) // Fade transition
                               .animation(.easeInOut, value: hasSeenLandingPage)
                       } else {
                           // Show the Landing Page with a fade-in transition
                           LandingView()
                               .transition(.opacity) // Fade transition
                               .animation(.easeInOut, value: hasSeenLandingPage)
                       }
        }
    }
}

//#Preview {
//    SugaryAIApp()
//}

