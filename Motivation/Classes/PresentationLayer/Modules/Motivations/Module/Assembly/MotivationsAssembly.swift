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
        
        container.register(MotivationsInteractor.self) { (r: Resolver, presenter: MotivationsPresenter) in
            let interactor = MotivationsInteractor()
            interactor.output = presenter
            
            return interactor
        }
        
        container.register(MotivationsRouter.self) { (r: Resolver, viewController: MotivationsViewController) in
            let router = MotivationsRouter()
            router.transitionHandler = viewController
            
            return router
        }
        
        container.register(MotivationsPresenter.self) { (r: Resolver, viewController: MotivationsViewController) in
            let presenter = MotivationsPresenter()
            presenter.view = viewController
            presenter.interactor = r.resolve(MotivationsInteractor.self, argument: presenter)
            presenter.router = r.resolve(MotivationsRouter.self, argument: viewController)
            presenter.shareService = r.resolve(ShareService.self)
            
            return presenter
        }
        
        container.register(MotivationsDataDisplayManager.self) { (r: Resolver, viewController: MotivationsViewController) in
            let dataDisplayManagerImpl = MotivationsDataDisplayManagerImpl()
            dataDisplayManagerImpl.output = viewController
            
            return dataDisplayManagerImpl
        }
        
        container.storyboardInitCompleted(MotivationsViewController.self) { r, viewController in
            viewController.output = r.resolve(MotivationsPresenter.self, argument: viewController)
            viewController.dataDisplayManager = r.resolve(MotivationsDataDisplayManager.self, argument: viewController)
        }
    }
    
}
