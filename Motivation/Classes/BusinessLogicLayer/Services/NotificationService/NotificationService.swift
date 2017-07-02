//
//  NotificationService.swift
//  Motivation
//
//  Created by Alex Zarochintsev on 7/2/17.
//  Copyright © 2017 [Zarochintsev Production];. All rights reserved.
//

import UIKit
import Foundation

struct LocalPushNotification {
    let title: String
    let text: String
    let fire: Date
    let userInfo: [AnyHashable : Any]
}

protocol NotificationService {
    
    func configure(_ application: UIApplication)
    
    func schedule(localPush: LocalPushNotification)

    func resetAllNotifications()
}
