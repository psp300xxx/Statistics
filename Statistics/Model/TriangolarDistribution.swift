//
//  TriangolarDistribution.swift
//  Statistics
//
//  Created by Luigi De Marco on 26/11/2018.
//  Copyright © 2018 Luigi De Marco. All rights reserved.
//

import Foundation


public class TriangolarDistribution : ProbabilityDistribution {
    
    let a,b,c : Double
    public var name : String? 
    
    public init(){
        a = 2
        c = 3
        b = 4
    }
    
    public init?(a : Double, b : Double, c : Double){
        if b <= a {
            return nil
        }
        if c < a || c > b {
            return nil
        }
        self.a = a
        self.b = b
        self.c = c
    }
    
    public func probabiltyAtTime(time: Double) -> Double {
        if time >= a && time < c {
            return 2.0*(time-a)/( (b-a)*(c-a) )
        }
        if time == c {
            return 2.0/(b-a)
        }
        if time > c && time <= b {
            return 2.0*(b - time) / ((b - a)*(b-c))
        }
        return 0
    }
    
    public func average() -> Double {
        return (a+b+c)/3
    }
    
    public func variance() -> Double {
        return ((a*a + b*b + c*c) - (a*b + a*c + b*c))/18.0
    }
    
    
}
