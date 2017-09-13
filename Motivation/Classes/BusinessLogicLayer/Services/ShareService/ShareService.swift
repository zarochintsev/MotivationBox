//
//  ShareService.swift
//  Motivation
//
//  Created by Alex Zarochintsev on 9/13/17.
//  Copyright © 2017 [Zarochintsev Production];. All rights reserved.
//

import Foundation

protocol ShareService: class {
    
    func shareMotivation(title: String, motivation: String)
}
