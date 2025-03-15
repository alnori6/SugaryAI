import SwiftUI

struct BottomTabBar: View {
    
    @State var selectedTab: Tabs
    @AppStorage("sidebarCustomizations") var tabViewCustomization: TabViewCustomization
    
    enum Tabs: Equatable, Hashable {
        case profile, scan, pantry
    }
    
    
    
    // MARK: - Custom Tab Bar Appearance
    private func customizeTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        //        appearance.backgroundColor = UIColor.systemBackground // Matches system theme
        
        // Apply Ultra Thin Blur Effect Instead of Background Color
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // ✅ Set the Tab Bar Background to Clear to Show Blur Effect
        appearance.backgroundEffect = blurEffect
        appearance.backgroundColor = UIColor.clear
        
        // ✅ Fetch Colors Correctly
        let secondaryColor = UIColor(named: "secondary")
        let accentColor = UIColor(Color.accentColor)
        
        // Customize Unselected Tabs
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: secondaryColor!, // text color when not selected
            .font: UIFont.systemFont(ofSize: 13, weight: .regular) // edit the font size
        ]
        appearance.stackedLayoutAppearance.normal.iconColor = secondaryColor // icons color when not selected
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributes // text modefier
        
        // Customize Selected Tabs
        let selectedAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: accentColor] // change to accent
        appearance.stackedLayoutAppearance.selected.iconColor = accentColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributes
        
        // Apply Forced TabBar Tint Color (
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().tintColor = accentColor //Ensures selected tab color is correct
    }
    
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(Tabs.profile)
            
            ScanView()
                .tabItem {
                    Label("Scan", systemImage: "vial.viewfinder")
                }
                .tag(Tabs.scan)
            
            PantryView()
                .tabItem {
                    Label("Pantry", systemImage: "archivebox.fill")
                }
                .tag(Tabs.pantry)
        }
        .tint(Color("AccentColor")) // ✅ Forces SwiftUI to use this color
        .tabViewCustomization($tabViewCustomization)
        .onAppear {
            customizeTabBarAppearance() // ✅ Update UIKit TabBar Styling
        }
        
    }
    
}

// MARK: - Dummy Views for Testing  will be removed
struct ProfileView: View {
    var body: some View {
        Text("Profile View")
    }
}

struct ScanView: View {
    var body: some View {
        Text("Scan View")
    }
}


// MARK: - Preview
#Preview {
    BottomTabBar(selectedTab: .pantry)
}
