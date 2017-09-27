//
//  MotivationServiceImpl.swift
//  Motivation
//
//  Created by Alex Zarochintsev on 9/24/17.
//  Copyright © 2017 [Zarochintsev Production];. All rights reserved.
//

import UIKit

class MotivationServiceImpl: NSObject {
    
    // MARK: - Constants
    
    fileprivate struct C {
        static let startIndex = 89
    }
}

// MARK: - MotivationService

extension MotivationServiceImpl: MotivationService {
    
    func requestMotivations(completion: (_ elements: [Motivation]) -> Void) {
        let day = Calendar(identifier: Calendar.Identifier.iso8601).ordinality(of: .day, in: .year, for: Date())!
        
        var elements: [Motivation] = []
        
        for index in C.startIndex...day {
            let title = "\(LS.Common.day.localized()) \(index)"
            let message = "\(index)".localized()
            
            let motivation = Motivation(title: title, message: message)
            
            elements.append(motivation)
        }
        
        elements.append(Motivation(title: "\(LS.Common.day.localized()) \(day+1)", message: LS.Motivations.new.localized()))
        
        completion(elements)
    }
    
    func todayMotivation() -> Motivation {
        let day = Calendar(identifier: Calendar.Identifier.iso8601).ordinality(of: .day, in: .year, for: Date())!
        
        let title = "\(LS.Common.day.localized()) \(day)"
        let message = "\(day)".localized()
        
        return Motivation(title: title, message: message)
    }
    
}
