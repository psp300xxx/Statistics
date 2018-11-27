//
//  NegativeExpGen.swift
//  Statistics
//
//  Created by Luigi De Marco on 26/11/2018.
//  Copyright © 2018 Luigi De Marco. All rights reserved.
//

import Foundation

public class NegativeExpGen : RandomVariableGenerator {
    
    public func generate(number: Int) -> [ProbabilityDistribution] {
        let lambdaMax : Double = 5
        let step = (lambdaMax/Double(number))
        var result : [ProbabilityDistribution] = []
        for i in 1..<number+1 {
            let distribution = NegativeExponentialDistribution(lambda: Double(i)*step )
            result.append(distribution)
        }
        return result
    }
    
    
}
