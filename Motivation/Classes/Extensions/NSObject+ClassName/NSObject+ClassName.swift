//
//  NSObject+ClassName.swift
//  Motivation
//
//  Created by Alex Zarochintsev on 7/2/17.
//  Copyright © 2017 [Zarochintsev Production];. All rights reserved.
//

import Foundation

public extension NSObject {
    
    /// Return a class name
    public var className: String {
        return String(describing: type(of: self))
    }
    
    /// Return a class name
    public class var className: String {
        return String(describing: self)
    }
    
}
