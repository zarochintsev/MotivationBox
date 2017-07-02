//
//  MotivationsAssembly.swift
//  Motivation
//
//  Created by Alex Zarochintsev on 7/1/17.
//  Copyright © 2017 [Zarochintsev Production];. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

class MotivationsAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(MotivationsInteractor.self) { (resolver: Resolver, presenter: MotivationsPresenter) in
            let interactor = MotivationsInteractor()
            interactor.output = presenter
            
            return interactor
        }
        
        container.register(MotivationsRouter.self) { (resolver: Resolver, viewController: MotivationsViewController) in
            let router = MotivationsRouter()
            router.transitionHandler = viewController
            
            return router
        }
        
        container.register(MotivationsPresenter.self) { (resolver: Resolver, viewController: MotivationsViewController) in
            let presenter = MotivationsPresenter()
            presenter.view = viewController
            presenter.interactor = resolver.resolve(MotivationsInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(MotivationsRouter.self, argument: viewController)
            
            return presenter
        }
        
        container.storyboardInitCompleted(MotivationsViewController.self) { r, viewController in
            viewController.output = r.resolve(MotivationsPresenter.self, argument: viewController)
        }
    }
    
}
