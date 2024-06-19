//
//  Result.swift
//  BalYeonGiAwards
//
//  Created by Hyun Lee on 6/19/24.
//

import Foundation
import SwiftUI

class Result {
    let image: UIImage
    let firstResult: (emotion: Emotions, probability: Double)
    let secondResult: (emotion: Emotions, probability: Double)
    
    init(image: UIImage, firstResult: (emotion: Emotions, probability: Double), secondResult: (emotion: Emotions, probability: Double)) {
        self.image = image
        self.firstResult = firstResult
        self.secondResult = secondResult
    }
}

extension Result: Comparable{
    static func == (lhs: Result, rhs: Result) -> Bool {
        return lhs.firstResult.probability == rhs.firstResult.probability
    }
    
    static func < (lhs: Result, rhs: Result) -> Bool {
        return lhs.firstResult.probability < rhs.firstResult.probability
    }
}
