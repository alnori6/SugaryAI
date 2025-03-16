//
//  PhotoPreviewView.swift
//  SugaryAI
//
//  Created by Noori on 16/03/2025.
//

import SwiftUI

struct PhotoPreviewView: View {
    let image: UIImage
    @Binding var isPresented: Bool

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: { isPresented = false }) {
                        Image(systemName: "xmark")
                            .padding(8)
                            .foregroundColor(.white)
                            .background(Color.white.opacity(0.4))
                            .cornerRadius(40)
                    }
                }
                .padding()
                Spacer()
                
                HStack {
                    Button(action: {
                        isPresented = false // Retake Photo
                    }) {
                        Text("Retake Photo")
                            .fontDesign(.rounded)
                            .font(.system(size: 16))
                            .padding(8)
                            .foregroundColor(.white)
                            .background(Color.white.opacity(0.4))
                            .cornerRadius(16)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        print("Use Photo") // Handle Next Step
                    }) {
                        Text("Continue")
                            .fontDesign(.rounded)
                            .font(.system(size: 16))
                            .padding(8)
                            .foregroundColor(.white)
                            .background(Color.blue.opacity(0.4))
                            .cornerRadius(16)
                    }
                }
                .padding()
            }
        }
        
        
        
        
    }
}




#Preview {
    @Previewable @State var isPresented = true
    return PhotoPreviewView(image: UIImage(), isPresented: $isPresented)
}
