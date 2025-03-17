
//
//  CameraViewModel.swift
//  SugaryAI
//
//  Created by Shatha Almukhaild on 14/09/1446 AH.
//

import Foundation
import CoreImage
import Observation
import UIKit

// To create a connection between CameraManger and CameraView
// it publishes the changes to CameraView using the Observation framework it allows us to publish the current frame in real-time
@Observable
class CameraViewModel: ObservableObject {
    // to track flash state if you want UI feedback
    var isFlashOn: Bool = false
    var currentFrame: CGImage?
    var selectedImage: UIImage?
    private let cameraManager = CameraManager()
    init(){
        Task {
            await handleCameraPreview()
        }
    }
    
    // Handle the update of AsyncStream and move the updates of the published variables to the MainActor updating the UI
    func handleCameraPreview() async {
        for await image in cameraManager.previewStream {
            Task { @MainActor in
                currentFrame = image
            }
        }
        
    }
    func capturePhoto() {
        Task {
            if let image = await cameraManager.capturePhoto() {
                await MainActor.run {
                    self.selectedImage = image
                }
            }
        }
    }
    // Expose the toggle flash functionality to the view
       func toggleFlash() {
           cameraManager.toggleFlash()
           // update the flash state here for UI feedback (Bolt Icon fill or slash)
           isFlashOn.toggle()
       }
}// end of CameraViewModel class

