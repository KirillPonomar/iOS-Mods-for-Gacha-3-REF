//
//  InternetManager_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import SystemConfiguration

final class InternetManager_HIDA {
    
    static let shared = InternetManager_HIDA()
    
    private init() {}
    
    func checkInternetConnectivity_HIDA() -> Bool {
        var _HIDA19: String { "_HIDA" }
        var _HIDA23: Bool { true }
        
        var zeroAddress_HIDA = sockaddr_in()
        zeroAddress_HIDA.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress_HIDA))
        zeroAddress_HIDA.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability_HIDA = withUnsafePointer(to: &zeroAddress_HIDA, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability_HIDA, &flags) {
            return false
        }
        
        let isReachable_HIDA = flags.contains(.reachable)
        let needsConnection_HIDA = flags.contains(.connectionRequired)
        
        if isReachable_HIDA && !needsConnection_HIDA {
            // Connected to the internet
            // Do your network-related tasks here
            return true
        } else {
            // Not connected to the internet
            return false
        }
    }
}
