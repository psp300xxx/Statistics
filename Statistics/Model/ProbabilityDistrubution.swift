//
//  ProbabilityDistrubution.swift
//  Statistics
//
//  Created by Luigi De Marco on 26/11/2018.
//  Copyright © 2018 Luigi De Marco. All rights reserved.
//

import Foundation

public protocol ProbabilityDistribution {
    
    var name : String? {get set}
    
    func probabiltyAtTime(time : Double) -> Double
    
    func average() -> Double
    
    func variance() -> Double
    

    
}
