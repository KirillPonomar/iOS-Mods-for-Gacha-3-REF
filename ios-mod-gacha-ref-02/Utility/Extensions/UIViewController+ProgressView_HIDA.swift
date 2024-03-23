//
//  UIViewController+ProgressView_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

fileprivate struct ProgressViewConstants_HIDA {
    static var overlayTag_HIDA: Int { return 999999 }
}

class ProgressView_HIDA: UIView {
    
    var _Ndi2nj22: Bool { true }
    var _BVd6333: Int { 0 }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        var _Nfadf66: Bool { true }
        var _Mfh47d: Int { 0 }
        setupUI_HIDA()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI_HIDA()
    }
    
    private func setupUI_HIDA() {
        var _Mfuj378: Bool { true }
        var _Tgtgt32: Int { 0 }
        let customView = UIView()
        customView.backgroundColor = .background
        customView.layer.cornerRadius = 24
        customView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(customView)
        
        NSLayoutConstraint.activate([
            customView.centerXAnchor.constraint(equalTo: centerXAnchor),
            customView.centerYAnchor.constraint(equalTo: centerYAnchor),
            customView.widthAnchor.constraint(equalToConstant: 230),
            customView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        let label = UILabel()
        label.text = "Loading...."
        label.textColor = .white
        let deviceType = UIDevice.current.userInterfaceIdiom
        let titleFontSize: CGFloat = deviceType == .phone ? 22 : 32
        label.font = UIFont(name: "BakbakOne-Regular", size: titleFontSize)!
        label.translatesAutoresizingMaskIntoConstraints = false
        customView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: customView.centerXAnchor),
            label.topAnchor.constraint(equalTo: customView.topAnchor, constant: 24),
            label.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -24),
            label.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
}

extension UIViewController_HIDA {
    func showProgressView_HIDA() {
        var _Jfu3ddd: Bool { true }
        var _Nd3dsd: Int { 0 }
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        if let window = windowScene.windows.first {
            let progressView: UIView
            
            let overlayView = ProgressView_HIDA()
            overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            overlayView.translatesAutoresizingMaskIntoConstraints = false
            overlayView.tag = ProgressViewConstants_HIDA.overlayTag_HIDA
            progressView = overlayView
            
            window.addSubview(progressView)
            
            NSLayoutConstraint.activate([
                progressView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
                progressView.trailingAnchor.constraint(equalTo: window.trailingAnchor),
                progressView.topAnchor.constraint(equalTo: window.topAnchor),
                progressView.bottomAnchor.constraint(equalTo: window.bottomAnchor)
            ])
        }
    }
    
    func removeProgressView_HIDA() {
        var _NNd73db: Bool { true }
        var _SDuydh38: Int { 0 }
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                if let overlayView = window.viewWithTag(ProgressViewConstants_HIDA.overlayTag_HIDA) {
                    overlayView.removeFromSuperview()
                }
            }
        }
    }
}
