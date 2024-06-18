//
//  ResultListViewModel.swift
//  BalYeonGiAwards
//
//  Created by Hyun Lee on 6/18/24.
//

import Foundation

import SwiftUI
import CoreML
import AVFoundation

class ResultListViewModel: ObservableObject{
    @Published var chosenImage: UIImage?
    
    var emotionDictionary = [0: "neutral", 1: "happiness", 2: "surprise", 3: "sadness",
                             4: "anger", 5: "disgust", 6: "fear"]
    
    private func imageToMLMultiArray(image: UIImage, size: CGSize) -> MLMultiArray? {
        guard let resizedImage = image.resize(to: size),
              let grayscaleImage = resizedImage.toGrayScale(),
              let cgImage = grayscaleImage.cgImage else {return nil}
        
        let width = Int(size.width)
        let height = Int(size.height)
        
        guard let pixelData = cgImage.dataProvider?.data,
              let data = CFDataGetBytePtr(pixelData) else{return nil}
        
        guard let mlMultiArray = try? MLMultiArray(shape: [1,1, NSNumber(value: height), NSNumber(value:width)], dataType: .float32) else {return nil}
        
        for y in 0..<height{
            for x in 0..<width{
                let pixelIndex = y * cgImage.bytesPerRow + x
                let pixelValue = Float(data[pixelIndex]) / 255.0
                mlMultiArray[[0,0, y as NSNumber, x as NSNumber]] = NSNumber(value: pixelValue)
            }
        }
        return mlMultiArray
    }
}

extension UIImage{
    func resize(to size: CGSize) -> UIImage?{
        let square = AVFoundation.AVMakeRect(aspectRatio: self.size, insideRect: .init(origin: .zero, size: size))
        let targetSize = square.size
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        let renderer = UIGraphicsImageRenderer(size: targetSize, format: format)
        let resized = renderer.image{ _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
        return resized
    }
    
    func toGrayScale() -> UIImage? {
        let context = CIContext(options: nil)
        guard let currentFilter = CIFilter(name: "CIPhotoEffectMono") else {return nil}
        let beginImage = CIImage(image: self)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        guard let output = currentFilter.outputImage else {return nil}
        guard let cgImage = context.createCGImage(output, from: output.extent) else {return nil}
        return UIImage(cgImage: cgImage)
    }
}
