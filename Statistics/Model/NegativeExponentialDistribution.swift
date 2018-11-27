//
//  NegativeExponentialDistribution.swift
//  Statistics
//
//  Created by Luigi De Marco on 26/11/2018.
//  Copyright © 2018 Luigi De Marco. All rights reserved.
//

import Foundation

public class NegativeExponentialDistribution : ProbabilityDistribution {
    
    private let lambda : Double
    
    public init(lambda : Double){
        self.lambda = lambda
    }
    
    public init(){
        self.lambda = 1
    }
    
    public func average() -> Double {
        return 1/lambda
    }
    
    public func variance() -> Double {
        return 1/(lambda*lambda)
    }
    
    public func probabiltyAtTime(time: Double) -> Double {
        return 1 - exp(-lambda*time)
    }
    
    
}
