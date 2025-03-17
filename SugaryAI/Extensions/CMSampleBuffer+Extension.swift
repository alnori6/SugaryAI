//
//  CMSampleBuffer+Extension.swift
//  SugaryAI
//
//  Created by Shatha Almukhaild on 04/09/1446 AH.
//

import AVFoundation
import CoreImage
// convert CMSampleBuffer to CG Image enabling the implmentation of CaptureOutpout method
extension CMSampleBuffer {
    var cgImage: CGImage? {
        let pixelBuffer: CVPixelBuffer? = CMSampleBufferGetImageBuffer(self)
        
        guard let imagePixelBuffer = pixelBuffer else {
            return nil
        }
        
        return CIImage(cvPixelBuffer: imagePixelBuffer).cgImage
    }
}
 
