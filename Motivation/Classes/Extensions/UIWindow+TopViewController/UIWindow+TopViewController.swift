//
//  UIWindow+TopViewController.swift
//  Motivation
//
//  Created by Alex Zarochintsev on 9/13/17.
//  Copyright © 2017 [Zarochintsev Production];. All rights reserved.
//

import UIKit

extension UIWindow {
    
    var topViewController: UIViewController? {
        var topViewController = rootViewController
        
        while let presentedViewController = topViewController?.presentedViewController {
            topViewController = presentedViewController
        }
        
        return topViewController
    }
    
}
