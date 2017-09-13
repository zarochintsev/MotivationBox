//
//  ServiceAssembly.swift
//  Motivation
//
//  Created by Alex Zarochintsev on 9/13/17.
//  Copyright © 2017 [Zarochintsev Production];. All rights reserved.
//

import Swinject

class ServiceAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(NotificationService.self) { (r: Resolver) in
            return NotificationServiceImpl()
        }
    }
    
}
