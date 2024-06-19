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
    var chosenEmotion: Emotions?
    var results = [Result]() //might need to bind this
    
    var emotionDictionary = [0: Emotions.neutral, 1: Emotions.happiness, 2: Emotions.surprise, 3: Emotions.sadness,
                             4: Emotions.anger, 5: Emotions.disgust, 6: Emotions.fear]
    
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
            
            guard let emotion = chosenEmotion else {return}
            var chosenEmotionProbabilityIndex = emotionDictionary.first(where: {$0.value == emotion})?.key
            guard let index = chosenEmotionProbabilityIndex else {return}
            let chosenEmotionProbability = probabilities[index]
            
            var nextMaxProbability = chosenEmotionProbability
            var nextMaxProbabilityIndex = index
            for i in 0..<probabilities.count{
                guard i != index else {return}
                
                if probabilities[i] > nextMaxProbability{
                    nextMaxProbability = probabilities[i]
                    nextMaxProbabilityIndex = i
                }
            }
            var nextEmotion = emotionDictionary[nextMaxProbabilityIndex]
            
            guard let firstEmotion = chosenEmotion,
                    let secondEmotion = nextEmotion,
                    let image = chosenImage else {return}
            var result = Result(image: image, firstResult: (firstEmotion, roundedProbability(from: chosenEmotionProbability)), secondResult: (secondEmotion, roundedProbability(from: nextMaxProbability)))
            
            results.append(result)
            
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
    
    // MARK: ROUNDING UP PROBABILITY
    private func roundedProbability(from originalNum: Double) -> Double{
        var formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        let value = originalNum * 100
        if let formattedString = formatter.string(for: value) {
            guard let result = Double(formattedString) else {return 0.0}
            return result
        }
        return 0.0
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
