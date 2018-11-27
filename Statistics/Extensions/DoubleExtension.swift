//
//  DoubleExtension.swift
//  Statistics
//
//  Created by Luigi De Marco on 26/11/2018.
//  Copyright © 2018 Luigi De Marco. All rights reserved.
//

import Foundation

public extension Array {
    func subrange(untilIndex : Int) -> [Element]{
        var newArray : [Element] = []
        for i in 0..<untilIndex {
            newArray.append(self[i])
        }
        return newArray
    }
}

public extension Double {
    
    //Double is supposed to be between 0 and 1
    func boolean(trueWithProbability probability : Double = 0.5) -> Bool {
        let setSize = 101
        let random = Int(arc4random_uniform(UInt32(setSize)))
        let realProbability = probability >= 0 && probability <= 1 ? probability : 1.0
        let borderValue = Int(Double(setSize) * realProbability)
        return random < borderValue
    }
    
    
//    Calculates average using Knuth Algorithm
    static func average(_ inputData : [Double] , _ untilIndex : Int?  = nil ) ->Double {
        var untilVar = inputData.count
        if let untilIndex = untilIndex {
            if untilIndex == 0 {
                return 0
            }
            untilVar = untilIndex
        }
        if inputData.isEmpty {
            return 0
        }
        var average = inputData[0]
        for i in 1..<untilVar {
            average = ( (average*( Double(i) ) ) + inputData[i] ) / (Double(i+1) )
        }
        return average
    }
    
    static func variance(_ inputData : [Double]) -> Double {
        var variance : Double = 0
        for i in 0..<inputData.count {
            let numerator = ( variance * Double(i) ) + ( (inputData[i] - Double.average(inputData, i+1) ) * ( inputData[i] - Double.average(inputData, i) ) )
            variance = numerator/Double(i+1)
        }
        return variance
    }
  
    @available(*, deprecated, message: "use variance instead, because this was only a try")
    static func classicVariance(_ inputData : [Double]) -> Double {
        let average = Double.average(inputData)
        var tot : Double = 0
        for i in inputData {
            tot += ( ((i - average) * (i - average))/Double(inputData.count) )
        }
        return tot
    }
    
    
//    Calculates Average using definition
    @available(*, deprecated, message: "use average instead, because this was only a try")
    static func classicAverage(_ inputData : [Double]) -> Double{
        var avg : Double = 0
        for i in inputData {
            avg+=i
        }
        return avg/Double(inputData.count)
    }
    
}
