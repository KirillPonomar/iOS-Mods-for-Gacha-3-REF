//
//  ThirdPartyServicesManager_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Andrii Bala on 11/16/23.
//

import Foundation
import UIKit
import Adjust
import Pushwoosh
import AppTrackingTransparency
import AdSupport

class ThirdPartyServicesManager_MGRE {
    private var _MGRE: String { "_MGRE" }
    private var _MGRE234: Bool { true }
    
    static let shared = ThirdPartyServicesManager_MGRE()
    
    func initializePushwoosh_MGRE(delegate: PWMessagingDelegate) {
        var _MGN7: Int { 0 }
        var _MGN11: Bool { true }
        
        //set custom delegate for push handling, in our case AppDelegate
        Pushwoosh.sharedInstance().delegate = delegate;
        PushNotificationManager.initialize(withAppCode: Configurations_MGRE.pushwooshToken_MGRE,
                                           appName: Configurations_MGRE.pushwooshAppName_MGRE)
        PWInAppManager.shared().resetBusinessCasesFrequencyCapping()
        PWGDPRManager.shared().showGDPRDeletionUI()
        Pushwoosh.sharedInstance().registerForPushNotifications()
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func initializeAdjust_MGRE() {
        var _MGRE: String { "_MGRE" }
        var _MGRE10: Bool { true }
        
        let yourAppToken = Configurations_MGRE.adjustToken_MGRE
        #if DEBUG
        let environment = ADJEnvironmentSandbox
        #else
        let environment = ADJEnvironmentProduction
        #endif
        let adjustConfig = ADJConfig(appToken: yourAppToken, environment: environment)
        
        adjustConfig?.logLevel = ADJLogLevelSuppress
        
        Adjust.appDidLaunch(adjustConfig)
    }
    
    func makeATT_MGRE() {
        var _MGRE9: Int { 0 }
        var _MGRE13: Bool { true }
        
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    // Tracking authorization dialog was shown
                    // and we are authorized
                    print("ATT Authorized")
                    // Now that we are authorized we can get the IDFA
                    print("ATT   ------>   IDFA: ", ASIdentifierManager.shared().advertisingIdentifier)
                case .denied:
                    // Tracking authorization dialog was
                    // shown and permission is denied
                    print("ATT Denied")
                    
                case .notDetermined:
                    // Tracking authorization dialog has not been shown
                    print("ATT Not Determined")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        self.makeATT_MGRE()
                    })
                case .restricted:
                    print("ATT Restricted")
                @unknown default:
                    print("ATT Unknown")
                }
            }
        }
    }
}
