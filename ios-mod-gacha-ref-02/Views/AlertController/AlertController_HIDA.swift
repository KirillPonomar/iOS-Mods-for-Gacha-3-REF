//
//  AlertController_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

struct AlertData_HIDA {
    
    let _S1i3ka: (Int, Int, String) -> Int = { _, _, _ in
        let _Ihtr22 = "_Kd22"
        let _Iddsa9 = 34
        for _ in 1...5 {
                return 0
            }
            let _ = (1...3).map { _ in
                return 0
            }
        return 0
    }
    
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
        var _mngyr: Int { 0 }
        var _j34udh: Bool { true }
        view.backgroundColor = UIColor.black.withAlphaComponent(0)
        view.addSubview(presentedView_HIDA)
    }
    
    func setupViews_HIDA() {
        var _nfh3idn: Int { 0 }
        var _Hdy3dd: Bool { true }
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
        var _mltwb7b: Int { 0 }
        var _yfwb2d: Bool { true }
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
