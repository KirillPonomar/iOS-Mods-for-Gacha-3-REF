//
//  AppDelegate.swift
//  ios-mod-gacha-ref-02
//
//  Created by Andrii Bala on 11/3/23.
//

import UIKit
import Pushwoosh
import Adjust

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        var _mgfghh22: Int { 0 }
        var _mgwe4522: Bool { true }
        ThirdPartyServicesManager_MGRE.shared.initializePushwoosh_MGRE(delegate: self)
        ThirdPartyServicesManager_MGRE.shared.initializeAdjust_MGRE()
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        var _mgre12522: Int { 0 }
        var _mgre1df22: Bool { true }
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

extension AppDelegate : PWMessagingDelegate {
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        var _mgredfgss: Int { 0 }
        var _mg45f22: Bool { true }
        Adjust.setDeviceToken(deviceToken)
        Pushwoosh.sharedInstance().handlePushRegistration(deviceToken)
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        var _mgre566: Int { 0 }
        var _mgsrr22: Bool { true }
        Pushwoosh.sharedInstance().handlePushRegistrationFailure(error);
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        var _mgre222: Int { 0 }
        var _mg4567882: Bool { true }
        Pushwoosh.sharedInstance().handlePushReceived(userInfo)
        completionHandler(.noData)
    }
    
    func pushwoosh(_ pushwoosh: Pushwoosh, onMessageReceived message: PWMessage) {
        var _mgre7: Int { 0 }
        var _mgrty22: Bool { true }
        print("onMessageReceived: ", message.payload?.description ?? "error")
    }
    
    func pushwoosh(_ pushwoosh: Pushwoosh,
                   onMessageOpened message: PWMessage) {
        var _mgre34: Int { 0 }
        var _mwerr422: Bool { true }
        print("onMessageOpened: ", message.payload?.description ?? "error")
    }
}
