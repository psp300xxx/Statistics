//
//  ParallelDistributionGenerator.swift
//  Statistics
//
//  Created by Luigi De Marco on 27/11/2018.
//  Copyright © 2018 Luigi De Marco. All rights reserved.
//

import Foundation

public class ParallelDistributionGenerator {
    private let randomGenerator : RandomVariableGenerator
    
    public init(randomGenerator : RandomVariableGenerator){
        self.randomGenerator = randomGenerator
    }
    
    public func generate(number : Int, completionHandler : ( ([ProbabilityDistribution]) -> () )?){
        DispatchQueue.global(qos: .background).async {
            let array = self.randomGenerator.generate(number: number)
            DispatchQueue.main.async {
                if let handler = completionHandler {
                    handler(array)
                }
            }
        }
    }
    
}
