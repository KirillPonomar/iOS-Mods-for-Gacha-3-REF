//
//  ServicesManager_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import Foundation
import UIKit
import Adjust
import Pushwoosh
import AppTrackingTransparency
import AdSupport

class ServicesManager_HIDA {
    static let shared = ServicesManager_HIDA()
    
    func initializeAdjust_HIDA() {
        let yourAppToken = "mdf8h7jslxc0"
#if DEBUG
        let environment = (ADJEnvironmentSandbox as? String)!
#else
        let environment = (ADJEnvironmentProduction as? String)!
#endif
        let adjustConfig = ADJConfig(appToken: yourAppToken, environment: environment)
        
        adjustConfig?.logLevel = ADJLogLevelVerbose
        Adjust.appDidLaunch(adjustConfig)
    }
    
    func initializePushwoosh_HIDA(delegate: PWMessagingDelegate) {
        //set custom delegate for push handling, in our case AppDelegate
        Pushwoosh.sharedInstance().delegate = delegate;
        PushNotificationManager.initialize(withAppCode: "AC727-9D9BE", appName: "test")
        PWInAppManager.shared().resetBusinessCasesFrequencyCapping()
        PWGDPRManager.shared().showGDPRDeletionUI()
        Pushwoosh.sharedInstance().registerForPushNotifications()
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func makeATT_HIDA() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    print("Authorized")
                    let idfa = ASIdentifierManager.shared().advertisingIdentifier
                    print("Пользователь разрешил доступ. IDFA: ", idfa)
                    let authorizationStatus = Adjust.appTrackingAuthorizationStatus()
                    Adjust.updateConversionValue(Int(authorizationStatus))
                    Adjust.checkForNewAttStatus()
                    print(ASIdentifierManager.shared().advertisingIdentifier)
                case .denied:
                    print("Denied")
                case .notDetermined:
                    print("Not Determined")
                case .restricted:
                    print("Restricted")
                @unknown default:
                    print("Unknown")
                }
            }
        }
    }
}
