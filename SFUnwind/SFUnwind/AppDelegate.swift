//
// AppDelegate.swift
// SFUnwind
// Project Group 5: SFU CMPT 276
// Primary programmer: Adam Badke
// Contributing Programmers: All
// Known issues:
//
// Note: All files in this project conform to the coding standard included in the SFUnwind HW3 Quality Assurance Documentation

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate{
    
    var window: UIWindow?
    
    // Sets up notifications
    // Input: UIApplication, launchOptions
    // Output: Bool
    // No dependencies
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //notification thing - start
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.alert, .sound, .badge]) { (Bool, error) in
                if error != nil {
                    //Handle error
                    print(error!)
                }
            }
            
            //let actionOne = UNNotificationAction(identifier: "actionOne", title: "Open app", options: [.foreground])
            //let categoryOne = UNNotificationCategory(identifier: "notificationID1", actions: [actionOne], intentIdentifiers: [], options: [])
            //center.setNotificationCategories([categoryOne])
        }
        else {
            let notificationTypes: UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound]
            let pushNotificationSetting = UIUserNotificationSettings(types: notificationTypes, categories: nil)
            application.registerUserNotificationSettings(pushNotificationSetting)
            application.registerForRemoteNotifications()
        }
        return true
    }
    
    // ios 9 confirm
    // Input: UIApplication, deviceToken
    // Output: None
    // Dependency: application(...) has run
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){
        print("DEVICE TOKEN = \(deviceToken)")
    }
    
    // ios 9 error
    // Input: UIApplication, error
    // Output: None
    // Dependency: application(...) has run
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error){
        print(error)
    }
    // ios 9 user info get
    // Input: UIApplication, didRecieveNoti...
    // Output: None
    // Dependency: application(...) has run
    private func application(application: UIApplication, didRecieveRemoteNotification userInfo: [NSObject : AnyObject]) {
        print(userInfo)
        
    }
    
    // ios 10 notification settings
    // Input: notCenter, notification, completeHandler
    // Output: Void
    // Dependency: application(...) has run
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
    
    // ios 10 notification response
    // Input: notCenter, notification response, completionHandler
    // Output: Void
    // Dependency: application(...) has run
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == "actionOne" {
            DispatchQueue.main.async(execute: {
                self.notificationActionTapped()
            })
        }
    }
    
    // ios 10 notification tapped
    // Input: None
    // Output: None
    // Dependency: application(...) has run
    @available(iOS 10.0, *)
    func notificationActionTapped(){
        let alert = UIAlertController(title: "Hi", message: "Welcome back!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(UIAlertAction) in
            //Do something
        }))
        let pushedViewController = (self.window?.rootViewController as! UINavigationController).viewControllers
        let presentedViewController = pushedViewController[pushedViewController.count - 1]
        presentedViewController.present(alert, animated: true, completion: nil)
    }

    // DEFAULT FUNCTIONS
    // Input: UIApplication
    // Output: None
    // No dependencies
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    // Input: UIApplication
    // Output: None
    // No dependencies
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    // Input: UIApplication
    // Output: None
    // No dependencies
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    // Input: UIApplication
    // Output: None
    // No dependencies
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    // Input: UIApplication
    // Output: None
    // No dependencies
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

