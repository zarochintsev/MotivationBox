//
// MotivationsInteractor.swift
//
// MIT License
//
// Copyright (c) 2017 Alex Zarochintsev
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import UIKit

class MotivationsInteractor {
    
    // MARK: - Constants
    
    fileprivate struct C {
        static let startIndex = 89
    }
    
    /// Reference to the Presenter's output interface.
    weak var output: MotivationsInteractorOutput!
}

// MAKR: - MotivationsInteractorInput

extension MotivationsInteractor: MotivationsInteractorInput {
    
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
