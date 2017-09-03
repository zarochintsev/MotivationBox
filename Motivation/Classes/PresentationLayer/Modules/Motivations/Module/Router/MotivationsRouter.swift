//
//  MotivationsRouter.swift
//  Motivation
//
//  Created by Alex Zarochintsev on 7/1/17.
//  Copyright © 2017 [Zarochintsev Production];. All rights reserved.
//

import UIKit
import LightRoute

class MotivationsRouter: MotivationsRouterInput {
    
    /// This property contain protocol protected view controller for transition.
    weak var transitionHandler: TransitionHandler!
    
    
    // MARK: - MotivationsRouterInput
    
    func shareMotivation(motivation: String) {
        let activityViewController = UIActivityViewController(activityItems: [motivation], applicationActivities: nil)
        (transitionHandler as! UIViewController).present(activityViewController, animated: true, completion: nil)
    }
}
