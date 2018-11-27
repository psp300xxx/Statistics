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
        let step = ((lambdaMax)/Double(number))
        var result : [ProbabilityDistribution] = []
        for i in 1..<number+1 {
            let distribution = NegativeExponentialDistribution(lambda: Double(i)*step )
            distribution.name = "Negative Exp Distribution"
            result.append(distribution)
        }
        for i in 1..<number+1 {
            let distribution = NegativeExponentialDistribution(lambda: Double(i)*step*(-1) )
            distribution.name = "Negative Exp Distribution"
            result.append(distribution)
        }
        result.sort { (da, db) -> Bool in
            if let da = da as? NegativeExponentialDistribution, let db = db as? NegativeExponentialDistribution {
                return da.LAMBDA > db.LAMBDA
            }
            return false
        }
        return result
    }
    
    
}
