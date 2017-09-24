//
// MotivationsAssembly.swift
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
import Swinject
import SwinjectStoryboard

class MotivationsAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(MotivationsInteractor.self) { (r: Resolver, presenter: MotivationsPresenter) in
            let interactor = MotivationsInteractor()
            interactor.output = presenter
            interactor.motivationService = r.resolve(MotivationService.self)
            
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
