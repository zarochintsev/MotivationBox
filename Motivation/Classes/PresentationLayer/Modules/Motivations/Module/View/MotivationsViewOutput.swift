//
//  MotivationsViewOutput.swift
//  Motivation
//
//  Created by Alex Zarochintsev on 7/1/17.
//  Copyright © 2017 [Zarochintsev Production];. All rights reserved.
//

import Foundation

protocol MotivationsViewOutput: class {
    
    func viewDidLoad()
    
    func viewDidLayoutSubviews()
    
    func didTapOnMotivation(title: String, motivation: String)
}
