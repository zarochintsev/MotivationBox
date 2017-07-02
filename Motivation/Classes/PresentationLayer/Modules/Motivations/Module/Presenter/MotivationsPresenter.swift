//
//  MotivationsPresenter.swift
//  Motivation
//
//  Created by Alex Zarochintsev on 7/1/17.
//  Copyright © 2017 [Zarochintsev Production];. All rights reserved.
//

import UIKit

class MotivationsPresenter {
    
    /// Reference to the View (weak to avoid retain cycle).
    weak var view: MotivationsViewInput!
    
    /// Reference to the Interactor's interface.
    var interactor: MotivationsInteractorInput!
    
    /// Reference to the Router.
    var router: MotivationsRouterInput!
}

// MARK: - MotivationsViewOutput

extension MotivationsPresenter: MotivationsViewOutput {
    
    func viewDidLoad() {
        interactor.requestMotivations()
    }
    
    func viewDidLayoutSubviews() {
        view.scrollToPenultimateItem()
    }
    
}

// MARK: - MotivationsInteractorOutput

extension MotivationsPresenter: MotivationsInteractorOutput {
    
    func updatedMotivations(_ elements: [Motivation]) {
        view.updateMotivations(elements)
    }
    
}
