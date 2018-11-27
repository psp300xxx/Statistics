//
//  RandonVariableGenerator.swift
//  Statistics
//
//  Created by Luigi De Marco on 26/11/2018.
//  Copyright © 2018 Luigi De Marco. All rights reserved.
//

import Foundation

public protocol RandomVariableGenerator {
    func generate(number : Int) -> [ProbabilityDistribution]
}
