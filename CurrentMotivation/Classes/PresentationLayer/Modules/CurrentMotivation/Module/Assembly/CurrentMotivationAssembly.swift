//
// CurrentMotivationAssembly.swift
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

class CurrentMotivationAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(CurrentMotivationInteractor.self) { (r: Resolver, presenter: CurrentMotivationPresenter) in
            let interactor = CurrentMotivationInteractor()
            interactor.output = presenter
            interactor.motivationService = r.resolve(MotivationService.self)
            
            return interactor
        }
        
        container.register(CurrentMotivationRouter.self) { (r: Resolver, viewController: CurrentMotivationViewController) in
            let router = CurrentMotivationRouter()
            router.transitionHandler = viewController
            
            return router
        }
        
        container.register(CurrentMotivationPresenter.self) { (r: Resolver, viewController: CurrentMotivationViewController) in
            let presenter = CurrentMotivationPresenter()
            presenter.view = viewController
            presenter.interactor = r.resolve(CurrentMotivationInteractor.self, argument: presenter)
            presenter.router = r.resolve(CurrentMotivationRouter.self, argument: viewController)
            
            return presenter
        }
        
        container.storyboardInitCompleted(CurrentMotivationViewController.self) { r, viewController in
            viewController.output = r.resolve(CurrentMotivationPresenter.self, argument: viewController)
        }
    }

}
