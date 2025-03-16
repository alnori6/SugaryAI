//
//  SettingsViewModel.swift
//  SugaryAI
//
//  Created by Noori on 16/03/2025.
//


import Foundation
//import UIKit
import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var options: [SettingsOption] = [
        SettingsOption(title: "Contact us", iconName: "envelope", actionType: .contactUs),
        SettingsOption(title: "Rate Us", iconName: "star", actionType: .rateUs),
        SettingsOption(title: "Share app", iconName: "square.and.arrow.up", actionType: .shareApp)
    ]
    
    func handleAction(_ action: SettingsAction) {
        switch action {
        case .contactUs:
            openWhatsApp()
            
        case .rateUs:
            openAppStore()
            
        case .shareApp:
            shareAppOnWhatsApp()
        }
    }
    
    private func openWhatsApp() {
        let phoneNumber = "966559320935" // ضع رقم هاتفك هنا بصيغة دولية بدون "+"
        let urlString = "https://wa.me/\(phoneNumber)"
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    private func openAppStore() {
        let appStoreURL = "https://apps.apple.com/app/idYOUR_APP_ID" // ضع معرف تطبيقك هنا
        if let url = URL(string: appStoreURL) {
            UIApplication.shared.open(url)
        }
    }
    
    private func shareAppOnWhatsApp() {
        let appLink = "https://apps.apple.com/app/idYOUR_APP_ID" // ضع رابط التطبيق هنا
        let urlString = "https://wa.me/?text=جرب هذا التطبيق الرائع: \(appLink)"
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}
