//
//  TriangolarVariableGenerator.swift
//  Statistics
//
//  Created by Luigi De Marco on 27/11/2018.
//  Copyright © 2018 Luigi De Marco. All rights reserved.
//

import Foundation

public class TriangolarVariableGenerator : RandomVariableGenerator {
    
    public func generate(number: Int) -> [ProbabilityDistribution] {
        var result : [ProbabilityDistribution] = []
        let aBase = 0.1
        let bBase = 100.0
        
        for i in 2..<number+2 {
            var a : Double = 0
            var b : Double = 0.0
            while a >= b {
                 a = 1.0+aBase*Double(arc4random_uniform(UInt32(i)))
                 b = 1.0+Double(bBase*Double(arc4random_uniform(UInt32(i))))
            }
            let c = a + Double(arc4random_uniform(UInt32(Int(b-a))))
            let distribution = TriangolarDistribution(a: aBase*Double(arc4random_uniform(UInt32(i))), b: Double(bBase*Double(arc4random_uniform(UInt32(i)))), c: c)
            if let distribution = distribution {
                distribution.name = "Triangolar Distribution"
                result.append(distribution)
            }
        }
        return result
    }
    
    
}
