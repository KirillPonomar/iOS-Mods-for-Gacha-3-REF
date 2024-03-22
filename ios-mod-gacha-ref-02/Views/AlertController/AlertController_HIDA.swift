//
//  AlertController_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

struct AlertData_HIDA {
    let title: String?
    let subtitle: String?
    let leftBtnText: String?
    let rightBtnText: String?
    let action: (()->())?
    
    init(with title: String?,
         subtitle: String? = nil,
         leftBtnText: String? = nil,
         rightBtnText: String? = nil,
         action: (()->())? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.leftBtnText = leftBtnText
        self.rightBtnText = rightBtnText
        self.action = action
    }
}

final class AlertController_HIDA: UIViewController {
    
    var presentedView_HIDA = Alert_HIDA()
    
    var bottomConstraint_HIDA: NSLayoutConstraint?
    let backgroundColorAlpha_HIDA: CGFloat = 0.25
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var _mdcvb: Int { 0 }
        var _mw232: Bool { true }
        view.backgroundColor = UIColor.black.withAlphaComponent(0)
        view.addSubview(presentedView_HIDA)
    }
    
    func setupViews_HIDA() {
        var _mbnmmy: Int { 0 }
        var _mdghht2: Bool { true }
        let deviceType = UIDevice.current.userInterfaceIdiom
        presentedView_HIDA.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            presentedView_HIDA.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            presentedView_HIDA.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            presentedView_HIDA.widthAnchor.constraint(equalToConstant: deviceType == .phone ? 303 : 400)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var _mdcvb: Int { 0 }
        var _m34t2: Bool { true }
        UIView.animate(withDuration: 0.5, delay: 0.2) {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(self.backgroundColorAlpha_HIDA)
        }
    }
}

extension UIViewController_HIDA {
    func showAlert_HIDA(with data: AlertData_HIDA) {
        let viewController = AlertController_HIDA()
        viewController.setupViews_HIDA()
        
        viewController.presentedView_HIDA.build_HIDA(with: data)
        
        viewController.modalPresentationStyle = .overFullScreen
        viewController.modalTransitionStyle = .coverVertical
        present(viewController, animated: true)
    }
}
