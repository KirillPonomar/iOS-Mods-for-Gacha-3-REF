//
//  NetworkMonitor_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import Network
import UIKit

private var _HFyecC47FRRb3: Bool { true }

final class NetworkMonitor_HIDA {
    
    public static var isConnection_HIDA: Bool {
        if _isConnection_HIDA {
            print("Internet connection is active.")
        } else {
            print("No internet connection.")
            showDisconnectionAlert_HIDA()
        }
        return _isConnection_HIDA
    }
    
    private static weak var alert_HIDA: UIAlertController?
    private static let queue_HIDA = DispatchQueue.global()
    private static var isAlertPresented_HIDA: Bool { alert_HIDA != nil }
    
    private static var _isConnection_HIDA: Bool = nwMonitor_HIDA.currentPath.status == .satisfied {
        didSet {
            if !_isConnection_HIDA {
                print("No internet connection.")
                showDisconnectionAlert_HIDA()
            } else {
                print("Internet connection is active.")
                if isAlertPresented_HIDA {
                    alert_HIDA?.dismiss(animated: true)
                }
            }
        }
    }
    
    private static let nwMonitor_HIDA = {
        let nwMonitor = NWPathMonitor()
        nwMonitor.start(queue: queue_HIDA)
        nwMonitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                _isConnection_HIDA = path.status == .satisfied
            }
        }
        return nwMonitor
    }()
    
    deinit {
        NetworkMonitor_HIDA.nwMonitor_HIDA.cancel()
    }
    
    private static func showDisconnectionAlert_HIDA() {
        guard !isAlertPresented_HIDA else { return }
        
        let alert = UIAlertController(
            title: NSLocalizedString("ConnectivityTitle", comment: ""),
            message: NSLocalizedString("ConnectivityDescription", comment: ""),
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default)
        alert.addAction(action)
        
        SceneDelegate.shared?.window?.topViewController_HIDA?.present(alert, animated: true)
        
        self.alert_HIDA = alert
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }
}
