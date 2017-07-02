//
//  NotificationServiceImpl.swift
//  Motivation
//
//  Created by Alex Zarochintsev on 7/2/17.
//  Copyright © 2017 [Zarochintsev Production];. All rights reserved.
//

import UIKit

class NotificationServiceImpl: NotificationService {
    
    func configure(_ application: UIApplication) {
        let userNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        
        application.registerUserNotificationSettings(userNotificationSettings)
        application.registerForRemoteNotifications()
    }
    
    func schedule(localPush: LocalPushNotification) {
        let notification = UILocalNotification()
        notification.alertTitle = localPush.title
        notification.alertBody = localPush.text
        notification.fireDate = localPush.fire
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = localPush.userInfo
        UIApplication.shared.scheduleLocalNotification(notification)
    }
    
    func resetAllNotifications() {
        UIApplication.shared.cancelAllLocalNotifications()
    }
    
}
