//
//  CameraManager.swift
//  SugaryAI
//
//  Created by Noori on 16/03/2025.
//  Created by Shatha Almukhaild on 04/09/1446 AH.
//


import Foundation
import AVFoundation
import UIKit

/*
 MARK: Camera Manage class responsbilities
 
 1.To handle the Camera Feed (choosing which camera to use front or back, Adjusting the resolution and focus,
 make sure the app has permission to use the camera)
 2.Manage the camera session (turning on an d off the camera, photo capture, video feed, scanning )
 */

class CameraManager: NSObject{
    // An object to perform real time capture and add appropriate inputs and outputs
    private let captureSession = AVCaptureSession()
    
    // The media input from the capture device to capture session
    private var deviceInput: AVCaptureDeviceInput?
    
    // object used to have acess to video frames for processing
    private var videoOutput: AVCaptureVideoDataOutput?
    // object used to access photo output
    private var photoOutput: AVCapturePhotoOutput?
    
    // object repersents the hardware or virtual capture device that can provide one or more streams of media of a particular type
    // private let systemPreferredCamera2 = AVCaptureDevice.Position.back
    private let systemPreferredCamera = AVCaptureDevice.default(for: .video)
    
    /* The queue on which AVCaptureVideoDataOutputSampleBufferDelegate Callbacks should be invoked.
     It is mandatory to use a serial dispatch queue to guarantee that video frames will be delivered in order.
     */
    private var sessionQueue = DispatchQueue(label: "video.sessionQueue")
    
    
    /* Checks the current state of the authentication request if the user didnt grant permission to access the camera
     we will request it here , this request is only applicable if the resource is needed in our application
     */
    
    private var isAuthorized: Bool {
        get async {
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            // determine the user previously authorized the camera acess
            var isAuthorized = status == .authorized
            
            // if the system hasn't determined the user's authorization statues
            // explicitly promt them for approval.
            if status == .notDetermined {
                isAuthorized = await AVCaptureDevice.requestAccess(for: .video)
            }
            return isAuthorized
        }
    }
    
    // a variable that allows us to manage the continous stream of data
    
    private var  addToPreviewStream: ((CGImage) -> Void)?
    
    lazy var previewStream: AsyncStream<CGImage> = {
        AsyncStream { continuation in
            addToPreviewStream = {  cgImage in
                continuation.yield(cgImage)
            }
        }
    }()
    
    // MARK: - Intialization
    
    
    override init(){
        super.init()
        
        Task {
            let authorized = await isAuthorized
            if authorized{
                await configureSession()
                await startSession()
            }else{
                print("Camera acess denied")
            }
            
        }
    }
    // MARK: - Session Configuration to prepare the device
    private func configureSession() async {
        
        // To check the user authorization if allowed camera is available and can take the device input
        guard await isAuthorized,
              let systemPreferredCamera,
              let deviceInput = try? AVCaptureDeviceInput(device: systemPreferredCamera)
        else {
            print("Failed to get camera device or input")
            return }
        
        // Start configuration
        captureSession.beginConfiguration()
        
        // At the end of execution of the method commits the configuration to the running session
        defer {
            self.captureSession.commitConfiguration()
        }
        
        // define the video output and set the sample buffer delegate and the queue for invoking callbacks
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: sessionQueue)
        
        // check if input can be added to the capture session
        // add the input and output to capture session
        if captureSession.canAddInput(deviceInput) {
            captureSession.addInput(deviceInput)
            print("Camera input added")
            
        }else {
            print("unable to add device input to capture session")
            return }
        // checking if the output can be added to the session
        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
            print("Video output added")
            
        }else {
            print("unable to add video output to capture session")
            return
        }
        
        
        videoOutput.connection(with: .video)?.videoRotationAngle = 90
        
    }
    // MARK: - Start the session to begin reciving data
    private func startSession() async {
        
        // Checks th authorization
        guard await isAuthorized else {
            print("Camera is not authorized. Access Denied")
            return }
        // Start the capture session flow of data
        if !captureSession.isRunning {
            
            print("Starting Camera Session")
            captureSession.startRunning()
        } else {
            print("Camera session is already running")
        }
    }
    
    private func rotate(by angle: CGFloat, from connection: AVCaptureConnection) {
        guard connection.isVideoRotationAngleSupported(angle) else { return }
        connection.videoRotationAngle = angle
    }
    // MARK: - Function to turn the flash ON and OFF simply by tapping the flash icon
    func toggleFlash() {
        guard let device = AVCaptureDevice.default(for: .video) else {
            print("No video device available")
            return
        }
        guard device.hasTorch else {
            print("Device has no torch")
            return
        }
        
        do {
            try device.lockForConfiguration()
            if device.torchMode == .on {
                device.torchMode = .off
            } else {
                try device.setTorchModeOn(level: 1.0)
            }
            device.unlockForConfiguration()
        } catch {
            print("Error toggling flash: \(error)")
        }
    }
    
    
    //MARK: - capturePhoto
    func capturePhoto(completion: @escaping (UIImage?) -> Void) {
        guard let photoOutput = self.photoOutput else {
            print("Photo output not available")
            completion(nil)
            return
        }

        let settings = AVCapturePhotoSettings()
        settings.flashMode = .auto

        photoOutput.capturePhoto(with: settings, delegate: PhotoCaptureDelegate(completion: completion))
    }

    // PhotoCaptureDelegate to handle captured image
    class PhotoCaptureDelegate: NSObject, AVCapturePhotoCaptureDelegate {
        let completion: (UIImage?) -> Void
        
        init(completion: @escaping (UIImage?) -> Void) {
            self.completion = completion
        }
        
        func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
            if let error = error {
                print("Error capturing photo: \(error.localizedDescription)")
                completion(nil)
                return
            }
            if let imageData = photo.fileDataRepresentation(), let image = UIImage(data: imageData) {
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
    
    
    
    
}// End of CameraManger class


// Extension to receive the various buffer frames from the camera
extension CameraManager :AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let currentFrame = sampleBuffer.cgImage else {
            print("Can't convert sample buffer to CGImage")
            return }
        print("Frame Captured")
        addToPreviewStream?(currentFrame)
    }
}
