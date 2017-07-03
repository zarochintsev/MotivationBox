//
//  AppDelegate.swift
//  Motivation
//
//  Created by Alex Zarochintsev on 7/1/17.
//  Copyright © 2017 [Zarochintsev Production];. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var notificationService: NotificationService!
    
    
    // MARK: - UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        notificationService = ApplicationAssembly.assembler.resolver.resolve(NotificationService.self)
        notificationService.configure(application)
        
        FirebaseApp.configure()
        GADMobileAds.configure(withApplicationID: "ca-app-pub-8789103391812563~9137139532")
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        func fireDate() -> Date {
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let stringDate = dateFormatter.string(from: Date()).appending(" 10:00:00")
            
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let today = dateFormatter.date(from: stringDate)!
            
            let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
            
            return tomorrow
        }
        
        let local = LocalPushNotification(
            title: LS.LocalNotification.title.localized(),
            text: LS.LocalNotification.text.localized(),
            fire: fireDate())
        notificationService.schedule(localPush: local)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        notificationService.resetAllNotifications()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        
    }
    
}
