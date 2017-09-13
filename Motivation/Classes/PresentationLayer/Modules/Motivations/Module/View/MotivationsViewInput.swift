//
//  MotivationsViewInput.swift
//  Motivation
//
//  Created by Alex Zarochintsev on 7/1/17.
//  Copyright © 2017 [Zarochintsev Production];. All rights reserved.
//

import Foundation

protocol MotivationsViewInput: class {
    
    func configureWith(_ elements: [Motivation])
    
    func scrollToPenultimateItem()
}
