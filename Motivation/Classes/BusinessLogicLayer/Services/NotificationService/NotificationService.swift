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
    
    /// Title
    let title: String
    
    /// Message
    let text: String
    
    /// Fire date
    let fire: Date
}

protocol NotificationService {
    
    func configure(_ application: UIApplication)
    
    func schedule(localPush: LocalPushNotification)

    func resetAllNotifications()
}
