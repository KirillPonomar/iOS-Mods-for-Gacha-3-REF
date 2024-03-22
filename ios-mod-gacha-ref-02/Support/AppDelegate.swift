//
//  AppDelegate.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit
import Pushwoosh
import Adjust

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        var _vfPlf22: Int { 0 }
        var _Rfvhb35: Bool { true }
        ServicesManager_HIDA.shared.initializePushwoosh_HIDA(delegate: self)
        ServicesManager_HIDA.shared.initializeAdjust_HIDA()
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        var _RfvfGe5z3: Int { 0 }
        var _Rbhbr453: Bool { true }
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

extension AppDelegate: PWMessagingDelegate {

    //handle token received from APNS
    func application(_ application: UIApplication, DidRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Adjust.setDeviceToken(deviceToken)
        Pushwoosh.sharedInstance().handlePushRegistration(deviceToken)
    }

    //обработка ошибки получения токена
    func application(_ application: UIApplication, DidFailToRegisterForRemoteNotificationsWithError error: Error) {
        Pushwoosh.sharedInstance().handlePushRegistrationFailure(error);
    }
    
    //for iOS < 10 and quiet push-notification
    func application(_ application: UIApplication, DidReceiveRemoteNotification userInfo: [AnyHashable:Any], fetchCompletionHandler completionHandler:@escaping (UIBackgroundFetchResult) -> Void) {
        Pushwoosh.sharedInstance().handlePushReceived(userInfo)
        completionHandler(.noData)
    }
    
// this event is fired when the push gets received
    func pushwoosh(_ pushwoosh: Pushwoosh, onMessageReceived message: PWMessage) {
        print("onMessageReceived: ", message.payload?.description ?? "error")
    }
    
    // this event is fired when a user taps the notification
    func pushwoosh(_ pushwoosh: Pushwoosh, onMessageOpened message: PWMessage) {
        print("onMessageOpened: ", message.payload?.description ?? "error")
    }
}


