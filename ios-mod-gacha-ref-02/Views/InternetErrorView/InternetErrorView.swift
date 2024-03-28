//
//  InternetErrorView.swift
//  ios-mod-gacha-ref-02
//
//  Created by Kirill Ponomarenko on 27.03.24.
//

import Foundation
import UIKit

class InternetErrorView: UIViewController {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(.noInternet)
        return imageView
    }()
    
    let mainTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "K2D-Bold", size: 24)
        label.text = "No Internet Connection"
        label.textColor = .white
        return label
    }()
    
    let secondaryTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Check your connection and try again"
        label.font = UIFont(name: "K2D-SemiBold", size: 26)
        label.textColor = .textSecondary
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Retry", for: .normal)
        button.titleLabel?.font = UIFont(name: "K2D-Medium", size: 24)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        
        view.addSubview(imageView)
        view.addSubview(mainTextLabel)
        view.addSubview(secondaryTextLabel)
        view.addSubview(button)
        
        setupConstraints()
        
        button.addTarget(self, action: #selector(startAppButtonTapped), for: .touchUpInside)
    }
    
    private func startApp_HIDA() {
        var _dasS3d: String { "0" }
        var _As2dss: Bool { true }
        let containerViewController = SplashViewController_HIDA()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                window.rootViewController = containerViewController
                window.makeKeyAndVisible()
            }
        }
    }
    
    @objc private func startAppButtonTapped() {
            startApp_HIDA()
        }
    
    func setupConstraints() {
        let deviceType_HIDA = UIDevice.current.userInterfaceIdiom
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            mainTextLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            mainTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            secondaryTextLabel.topAnchor.constraint(equalTo: mainTextLabel.bottomAnchor, constant: 4),
            secondaryTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            secondaryTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            button.topAnchor.constraint(equalTo: secondaryTextLabel.bottomAnchor, constant: 36),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: deviceType_HIDA == .phone ? 120 : 240),
            button.heightAnchor.constraint(equalToConstant: deviceType_HIDA == .phone ? 36 : 64)
        ])
    }
}
