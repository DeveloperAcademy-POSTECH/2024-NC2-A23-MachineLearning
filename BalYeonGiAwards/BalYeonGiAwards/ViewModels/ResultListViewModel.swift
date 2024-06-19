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

enum Emotions: String, CaseIterable{
    case neutral = "무표정"
    case happiness = "기쁨"
    case surprise = "놀람"
    case sadness = "슬픔"
    case anger = "화남"
    case disgust = "혐오"
    case fear = "두려움"
}

class ResultListViewModel: ObservableObject{
    @Published var chosenImage: UIImage?
    
    var emotionDictionary = [0: "neutral", 1: "happiness", 2: "surprise", 3: "sadness",
                             4: "anger", 5: "disgust", 6: "fear"]
    
    // MARK: GETTING CLASSIFICATION OUTPUT FROM MODEL AFTER INPUTTING IMAGE DATA
    func performRequest(){
        guard let uiImage = chosenImage else{
            print("No Image")
            return
        }
        guard let multiArray = imageToMLMultiArray(image: uiImage, size: CGSize(width: 48, height: 48)) else {return}
        
        guard let mlModel = try? ModelNew(configuration: .init()) else{
            print("Failed to make model")
            return
        }
        do{
            let prediction = try mlModel.prediction(input: ModelNewInput(input: multiArray))
            print(prediction.var_267)
            let predictionArray = convertToArray(prediction.var_267)
            let probabilities = softmax(predictionArray)
            var resultString = ""
            for i in 0..<probabilities.count{
                guard let emotion = emotionDictionary[i] else {return}
                let percent = Double(round(1000 * probabilities[i]) / 10)
                resultString += "\(emotion): \(percent)% \n"
            }
        } catch{
            print("error: \(error)")
        }
    }
    
    // MARK: PRE-PROCESSING INPUT IMAGE
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
    
    // MARK: POST-PROCESSING OUTPUT
    func convertToArray(_ multiArray: MLMultiArray) -> [Double]{
        let count = multiArray.count
        var array: [Double] = []
        for i in 0..<count{
            array.append(multiArray[i].doubleValue)
        }
        return array
    }
    func softmax(_ x: [Double]) -> [Double]{
        let maxScore = x.max() ?? 0.0
        let expScores = x.map {
            exp($0 - maxScore)
        }
        let sumExpScores = expScores.reduce(0, +)
        return expScores.map{$0 / sumExpScores}
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
