//
//  MotivationService.swift
//  Motivation
//
//  Created by Alex Zarochintsev on 9/24/17.
//  Copyright © 2017 [Zarochintsev Production];. All rights reserved.
//

import Foundation

protocol MotivationService {
    
    func requestMotivations(completion: (_ elements: [Motivation]) -> Void)
    
    func todayMotivation() -> Motivation
}
