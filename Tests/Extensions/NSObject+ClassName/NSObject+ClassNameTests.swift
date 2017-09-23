//
//  NSObject+ClassNameTests.swift
//  Tests
//
//  Created by Alex Zarochintsev on 9/23/17.
//  Copyright © 2017 [Zarochintsev Production];. All rights reserved.
//

import XCTest

class NSObject_ClassNameTests: XCTestCase {
    
    func testClassName() {
        let className = NSObject.className
        XCTAssertTrue(className == "NSObject")
    }
    
}
