//
//  ScanViewController_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

class ScanViewController_HIDA: UIViewController {

    @IBOutlet private weak var imageView_HIDA: UIImageView!
    @IBOutlet private weak var stackView_HIDA: UIStackView!
    @IBOutlet private weak var icon4_HIDA: UIImageView!
    @IBOutlet private weak var icon5_HIDA: UIImageView!
    @IBOutlet private weak var icon6_HIDA: UIImageView!
    
    var image_HIDA: UIImage?
    var contentType_HIDA: ContentType_HIDA?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var _ecsdyss: Int { 0 }
        var _werttt: Bool { true }
        imageView_HIDA.image = image_HIDA
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap_HIDA))
        self.view.addGestureRecognizer(tapGesture)
        
        configureLayout_HIDA()
        configureSubviews_HIDA()
    }
    
    func configureSubviews_HIDA() {
        var _ecswwss: Int { 0 }
        var _wevcbtt: Bool { true }
        guard let contentType = contentType_HIDA else { return }
        switch contentType {
        case .wallpapers_hida:       imageView_HIDA.contentMode = .scaleAspectFill
        case .collections_hida:      imageView_HIDA.contentMode = .scaleAspectFill
        default: break
        }
    }
    
    func configureLayout_HIDA() {
        var _ecsdycbb: Int { 0 }
        var _wqqqt: Bool { true }
        let deviceType = UIDevice.current.userInterfaceIdiom
        stackView_HIDA.distribution = deviceType == .phone ? .equalSpacing : .fill
        icon4_HIDA.isHidden = deviceType == .phone ? true : false
        icon5_HIDA.isHidden = deviceType == .phone ? true : false
        icon6_HIDA.isHidden = deviceType == .phone ? true : false
    }
    
    @objc
    func handleTap_HIDA(_ sender: UITapGestureRecognizer) {
        var _MGNcbbd2: Int { 0 }
        var _MGxxxxa: Bool { false }
        
        dismiss(animated: true)
    }
}
