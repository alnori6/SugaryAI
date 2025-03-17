//
//  CIImage+Extension.swift
//  SugaryAI
//
//  Created by Shatha Almukhaild on 04/09/1446 AH.
//
import CoreImage


extension CIImage {
    var cgImage: CGImage? {
        let ciContext = CIContext()
        guard let cgImage = ciContext.createCGImage(self, from: self.extent)
        
        else {
            return nil
        }
        
        return cgImage
    }
}

