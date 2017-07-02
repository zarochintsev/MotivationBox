//
//  MotivationsViewInput.swift
//  Motivation
//
//  Created by Alex Zarochintsev on 7/1/17.
//  Copyright © 2017 [Zarochintsev Production];. All rights reserved.
//

import Foundation

protocol MotivationsViewInput: class {
    
    func updateMotivations(_ elements: [Motivation])
    
    func scrollToPenultimateItem()
}
