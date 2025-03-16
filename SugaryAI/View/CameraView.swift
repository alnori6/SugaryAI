//
//  CameraView.swift
//  SugaryAI
//
//  Created by Noori on 16/03/2025.
//

import SwiftUI
import PhotosUI
import Photos

struct CameraView: View {
    @State private var camera = CameraViewModel()
    // optional because there is no selection by default
    @State private var pickerItem: PhotosPickerItem?
    @State private var showwPopUp: Bool = false
    @State private var goOut: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // 1. Background: Live camera feed
                if let currentFrame = camera.currentFrame {
                    Image(currentFrame, scale: 1, label: Text("Camera feed"))
                        .resizable()
                        .scaledToFill()
                        .frame(width: getScreenBounds().width, height: getScreenBounds().height)
                        .clipped()
                } else {
                    Color.black.ignoresSafeArea()
                    VStack {
                        Button(action: {
                            goOut.toggle()
                            //                       dismiss() // ✅ Dismisses Camera View
                        }) {
                            VStack {
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.red)
                                Text("No Camera Feed")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                            .padding(20)
                            .background(Color.gray.opacity(0.2)) // Optional: Add background for better tap target
                            .clipShape(RoundedRectangle(cornerRadius: 10)) // Rounded edges
                        }
                        .buttonStyle(PlainButtonStyle()) // ✅ Removes button styling (like highlighting)
                        .navigationDestination(isPresented: $goOut) {
                            PantryView()
                        }
                    }
                }
                
                // 2. Overlay: Full-screen selected image
                if let selected = camera.selectedImage {
                    Image(uiImage: selected)
                        .resizable()
                        .scaledToFill()
                        .frame(width: getScreenBounds().width, height: getScreenBounds().height)
                        .clipped()
                        .transition(.opacity)
                        .zIndex(1)
                        .overlay(
                            VStack{
                                Spacer()
                                HStack(spacing: 250){
                                    Text("Cancel")
                                        .opacity(0)
                                    
                                    //Spacer()
                                    Button(action: {
                                        withAnimation { camera.selectedImage = nil }
                                    }) {
                                        
                                        
                                        ZStack {
                                            Circle()
                                                .fill(Color(hex: 0x7B7B7B))
                                                .opacity(0.41)
                                                .frame(width: 38, height: 38)
                                            Image(systemName: "xmark")
                                                .resizable()
                                                .frame(width: 16, height: 16)
                                                .foregroundStyle(Color.white)
                                        }
                                        
                                    }
                                    
                                    
                                    
                                }
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                            }
                            
                        )
                }
                
                // 3. Overlay: Camera UI Controls
                VStack {
                    Spacer()
                    // Top controls (flash toggle and close button)
                    HStack(spacing: 250) {
                        Button(action: {
                            camera.toggleFlash()
                        }) {
                            Image(systemName: camera.isFlashOn ? "bolt.fill" : "bolt.slash")
                                .resizable()
                                .aspectRatio(contentMode: .fit) // Maintain proportions
                                .frame(width: 30, height: 30) // Ensure consistent size
                            //                            .frame(width: camera.isFlashOn ? 20 : 30, height: 30)
                                .foregroundStyle(Color.white)
                        }
                        
                        Button(action: {
                            // Your action to dismiss the camera, if needed.
                        }) {
                            
                            ZStack {
                                Circle()
                                    .fill(Color(hex: 0x7B7B7B))
                                    .opacity(0.41)
                                    .frame(width: 38, height: 38)
                                Image(systemName: "xmark")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                    .foregroundStyle(Color.white)
                            }
                        }
                    }
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    // Bottom controls: Info button and Photo Picker button
                    HStack(spacing: 250) {
                        Button(action: {
                            // Action for camera instruction popup.
                        }) {
                            Image(systemName: "info.circle.fill")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .foregroundStyle(Color.white)
                        }
                        
                        // Photo picker button always shows the icon.
                        PhotosPicker(selection: $pickerItem, matching: .images) {
                            Image(systemName: "photo.on.rectangle.angled")
                                .resizable()
                                .frame(width: 40, height: 35)
                                .foregroundStyle(Color.white)
                        }
                        // To load the image from the library into the SwiftUI
                        .onChange(of: pickerItem) {
                            guard let pickerItem else { return }
                            Task {
                                do {
                                    if let data = try await pickerItem.loadTransferable(type: Data.self) {
                                        // Convert the data to a UIImage
                                        if let image = UIImage(data: data) {
                                            camera.selectedImage = image
                                        }
                                    }
                                } catch {
                                    print("Error loading image: \(error.localizedDescription)")
                                }
                            }
                        }
                    }
                    // Capture photo button
                    HStack {
                        Button(action: {
                            
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color(hex: 0xD9D9D9))
                                    .frame(width: 80, height: 80)
                                Circle()
                                    .fill(Color(hex: 0x838383))
                                    .frame(width: 66, height: 66)
                            }
                        }
                    }
                    Spacer()
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    CameraView()
}

// Extension for screen bounds
extension View {
    func getScreenBounds() -> CGRect {
        UIScreen.main.bounds
    }
}

// Extension to use hex colors.
extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 8) & 0xff) / 255,
            blue: Double((hex >> 0) & 0xff) / 255,
            opacity: alpha
        )
    }
}
