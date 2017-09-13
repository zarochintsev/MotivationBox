//
//  MotivationsDataDisplayManagerOutput.swift
//  Motivation
//
//  Created by Alex Zarochintsev on 9/13/17.
//  Copyright © 2017 [Zarochintsev Production];. All rights reserved.
//

import Foundation

protocol MotivationsDataDisplayManagerOutput: class {
    
    func didTapOnMotivation(title: String, motivation: String)
}
