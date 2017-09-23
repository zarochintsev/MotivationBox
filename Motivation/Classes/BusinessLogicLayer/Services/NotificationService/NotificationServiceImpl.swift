//
//  NotificationServiceImpl.swift
//  Motivation
//
//  Created by Alex Zarochintsev on 7/2/17.
//  Copyright © 2017 [Zarochintsev Production];. All rights reserved.
//

import UIKit

class NotificationServiceImpl {
    
}

// MARK: - NotificationService

extension NotificationServiceImpl: NotificationService {
    
    func configure(_ application: UIApplication) {
        let userNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        
        application.registerUserNotificationSettings(userNotificationSettings)
        application.registerForRemoteNotifications()
    }
    
    func schedule(localPush: LocalPushNotification) {
        let localNotification = UILocalNotification()
        localNotification.soundName = UILocalNotificationDefaultSoundName
        localNotification.alertTitle = localPush.title
        localNotification.alertBody = localPush.text
        localNotification.fireDate = localPush.fire
        
        UIApplication.shared.scheduleLocalNotification(localNotification)
    }
    
    func resetAllNotifications() {
        UIApplication.shared.cancelAllLocalNotifications()
    }
    
}
