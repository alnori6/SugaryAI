//
//  ButtonsUI.swift
//  SugaryAI
//
//  Created by Shatha Almukhaild on 13/09/1446 AH.
//

import SwiftUI


/// Primary button style with a pressed effect.
struct PrimaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Color(hex:0x636BFF)
            configuration.label
                .font(.system(size: 20, weight: .medium, design: .rounded))
             //   .font(.rounded)
                .foregroundColor(.white)
        }
        .frame(height: 52)
        .cornerRadius(8)
        .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
        .opacity(configuration.isPressed ? 0.8 : 1.0)
        .animation(.easeInOut, value: configuration.isPressed)
    }
}


/// Secondary button style with a pressed effect.
struct SecondaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Color(hex:0x636BFF)
            configuration.label
                .font(.system(size: 20, weight: .medium, design: .rounded))
             //   .font(.rounded)
                .foregroundColor(.white)
        }
        .frame(height: 52)
        .cornerRadius(37)
        .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
        .opacity(configuration.isPressed ? 0.8 : 1.0)
        .animation(.easeInOut, value: configuration.isPressed)
    }
}

struct ButtonsUI: View {
    var body: some View {
        Button("OK"){}.buttonStyle(PrimaryButton()).padding()
        Button("OK"){}.buttonStyle(SecondaryButton()).padding()
    }
}

#Preview {
    ButtonsUI()
}
