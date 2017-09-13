//
//  MotivationsInteractor.swift
//  Motivation
//
//  Created by Alex Zarochintsev on 7/1/17.
//  Copyright © 2017 [Zarochintsev Production];. All rights reserved.
//

import UIKit

class MotivationsInteractor: MotivationsInteractorInput {
    
    // MARK: - Constants
    
    private struct C {
        static let startIndex = 89
    }
    
    /// Reference to the Presenter's output interface.
    weak var output: MotivationsInteractorOutput!
    
    
    // MARK: - MotivationsInteractorInput
    
    func requestMotivations() {
        let day = Calendar(identifier: Calendar.Identifier.iso8601).ordinality(of: .day, in: .year, for: Date())!
        
        var elements: [Motivation] = []
        
        for index in C.startIndex...day {
            let title = "\(LS.Common.day.localized()) \(index)"
            let message = "\(index)".localized()
            
            let motivation = Motivation(title: title, message: message)
            
            elements.append(motivation)
        }
        
        elements.append(Motivation(title: "\(LS.Common.day.localized()) \(day+1)", message: LS.Motivations.new.localized()))
        
        output.updatedMotivations(elements)
    }
    
}
