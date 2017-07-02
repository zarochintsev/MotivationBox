//
//  Motivation.swift
//  Motivation
//
//  Created by Alex Zarochintsev on 7/1/17.
//  Copyright © 2017 [Zarochintsev Production];. All rights reserved.
//

import UIKit

class Motivation: NSObject {
    
    /// Motivation title
    let title: String
    
    /// Motivation message
    let message: String
    
    
    // MARK: - Init
    
    init (title: String, message: String) {
        self.title = title
        self.message = message
    }
    
}
