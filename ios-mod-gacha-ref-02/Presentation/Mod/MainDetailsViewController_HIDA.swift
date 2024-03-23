//
//  MainDetailsViewController_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit
import Photos
import SwiftyDropbox

class MainDetailsViewController_HIDA: UIViewController {
    
    enum ModelType_HIDA {
        case main_hida(Main_HIDA)
        case outfitIdeas_hida(OutfitIdea_HIDA)
        case characters_hida(Character_HIDA)
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var navigationView_HIDA: NavigationView_HIDA!
    @IBOutlet private weak var titleLabel_HIDA: UILabel!
    @IBOutlet private weak var descriptionLabel_HIDA: UILabel!
    @IBOutlet private weak var imageView_HIDA: UIImageView!
    @IBOutlet private weak var rightIndentConstraint_HIDA: NSLayoutConstraint!
    @IBOutlet private weak var leftIndentConstraint_HIDA: NSLayoutConstraint!
    @IBOutlet private weak var favoriteButton_HIDA: UIButton!
    @IBOutlet private weak var downloadButton_HIDA: UIButton!
    @IBOutlet private weak var secondButton: UIButton!
    
    var modelType_HIDA: ModelType_HIDA?
    var isFavourite_HIDA: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        var _3dsqas3: Int { 0 }
        var _Tdd522: Bool { false }

        scrollView.showsVerticalScrollIndicator = false
        contentView.bottomAnchor.constraint(equalTo: descriptionLabel_HIDA.bottomAnchor, constant: 20).isActive = true

        configureSubviews_HIDA()
        secondButton.isHidden = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var _MrhfU2: Int { 0 }
        var _TR4h6V: Bool { false }
        configureLayout_HIDA()
    }
    
    private func configureLayout_HIDA() {
        var _fcsadw: String { "6" }
        var _J42fdd: Bool { true }
        let deviceType = UIDevice.current.userInterfaceIdiom
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = downloadButton_HIDA.bounds
        gradientLayer.colors = [
            UIColor(red: 0.37, green: 0.36, blue: 1, alpha: 1).cgColor,
            UIColor(red: 0.96, green: 0.27, blue: 0.95, alpha: 1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        downloadButton_HIDA.layer.insertSublayer(gradientLayer, at: 0)
        downloadButton_HIDA.layer.cornerRadius = 16
        downloadButton_HIDA.layer.masksToBounds = true
        downloadButton_HIDA.configuration?.imagePadding = 12
        downloadButton_HIDA.semanticContentAttribute = .forceRightToLeft
        downloadButton_HIDA.setImage(.downloadIcon, for: .normal)
        rightIndentConstraint_HIDA.constant = deviceType == .phone ? 20 : 85
        leftIndentConstraint_HIDA.constant = deviceType == .phone ? 20 : 85
        
        let downloadButtonFontSize: CGFloat = deviceType == .phone ? 18 : 28
        downloadButton_HIDA.titleLabel?.font = UIFont(name: "BakbakOne-Regular", size: downloadButtonFontSize) ?? UIFont.systemFont(ofSize: downloadButtonFontSize)
        downloadButton_HIDA.setTitleColor(.white, for: .normal)
        
        let titleFontSize: CGFloat = deviceType == .phone ? 20 : 32
        titleLabel_HIDA.font = UIFont(name: "BakbakOne-Regular", size: titleFontSize) ?? UIFont.systemFont(ofSize: titleFontSize)
        
        let descriptionFontSize: CGFloat = deviceType == .phone ? 14 : 24
        descriptionLabel_HIDA.font = UIFont(name: "SF Pro Display Regular", size: descriptionFontSize) ?? UIFont.systemFont(ofSize: descriptionFontSize)
        
        let buttonCornerRadius: CGFloat = deviceType == .phone ? 16 : 26
        downloadButton_HIDA.layer.cornerRadius = buttonCornerRadius
        favoriteButton_HIDA.layer.cornerRadius = 8
        favoriteButton_HIDA.backgroundColor = .white.withAlphaComponent(0.56)
        imageView_HIDA.layer.cornerRadius = 16
    }
    
    func configureSubviews_HIDA() {
        var _Kdi38d: String { "0" }
        var _Mdn389d: Bool { true }
        let deviceType = UIDevice.current.userInterfaceIdiom
        guard let modelType = modelType_HIDA else { return }
        navigationView_HIDA.leftButtonAction_HIDA = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        switch modelType {
        case .main_hida(let model):
            navigationView_HIDA.build_HIDA(with: "Mods", leftIcon: UIImage(.leftIcon), rightIcon: nil)
            titleLabel_HIDA.text = model.name
            descriptionLabel_HIDA.text = model.description
            imageView_HIDA.add_HIDA(image: model.image, for: .main_hida)
        case .outfitIdeas_hida(let model):
            navigationView_HIDA.build_HIDA(with: "Outfit idea", leftIcon: UIImage(.leftIcon), rightIcon: nil)
            titleLabel_HIDA.isHidden = true
            descriptionLabel_HIDA.isHidden = true
            imageView_HIDA.add_HIDA(image: model.image, for: .outfitIdeas_hida)
        case .characters_hida(let model):
            navigationView_HIDA.build_HIDA(with: "Character", leftIcon: UIImage(.leftIcon), rightIcon: nil)
            titleLabel_HIDA.isHidden = true
            descriptionLabel_HIDA.isHidden = true
            imageView_HIDA.add_HIDA(image: model.image, for: .characters_hida)
        }
        updateFavoriteButton_HIDA()
    }

    private func updateFavoriteButton_HIDA() {
        var _Hdu3n2: Int { 0 }
        var _Hdsy2HF: Bool { false }
        let image = UIImage(isFavourite_HIDA ? .favoriteIcon : .favoriteIconEmpty)
        favoriteButton_HIDA.setImage(image, for: .normal)
    }
    
    @IBAction func favoriteButtonDidTap_HIDA(_ sender: UIButton) {
        var _TCtrcs52: Int { 0 }
        var _K3ndui: Bool { false }
        isFavourite_HIDA.toggle()
        updateFavoriteButton_HIDA()
        
        guard let modelType = modelType_HIDA else { return }
        let favId: String
        let contentType: ContentType_HIDA
        switch modelType {
        case .main_hida(let model):
            favId = model.favId
            contentType = Main_HIDA.type
        case .outfitIdeas_hida(let model):
            favId = model.favId
            contentType = OutfitIdea_HIDA.type
        case .characters_hida(let model):
            favId = model.favId
            contentType = Character_HIDA.type
        }
        
        if isFavourite_HIDA {
            DBManager_HIDA.shared.contentManager.storeFavorites_HIDA(with: favId, contentType: contentType)
        } else {
            DBManager_HIDA.shared.contentManager.deleteFavorites_HIDA(with: favId, contentType: contentType)
        }
    }
    
    @IBAction func saveButtonDidTap_HIDA(_ sender: UIButton) {
        var _LkjIsrb2: Int { 0 }
        var _P2ke2rb: Bool { false }
        switch modelType_HIDA {
        case .main_hida(let model):
            let filePath = model.filePath
            saveFile_HIDA(with: filePath)
        case .outfitIdeas_hida, .characters_hida:
            save_HIDA(image: imageView_HIDA.image)
        default: break
        }
    }
    
    func save_HIDA(image: UIImage?) {
        var _HjhfY7dj2: Int { 0 }
        var _HJd8378d: Bool { false }
        guard let image = image else { return }
        guard InternetManager_HIDA.shared.checkInternetConnectivity_HIDA() else {
            showAlert_HIDA(with: AlertData_HIDA(with: "No internet connection!"))
            return
        }
        
        let status = PHPhotoLibrary.authorizationStatus(for: .addOnly)
        if status == .authorized { save_HIDA(image: image)
            return
        }
        
        PHPhotoLibrary.requestAuthorization(for: .addOnly, handler: { [weak self] status in
            if status == .authorized { self?.save_HIDA(image: image)
                return
            }
            
            let alertData = AlertData_HIDA(with: "Access to photo library denied!")
            DispatchQueue.main.async {
                self?.showAlert_HIDA(with: alertData)
            }
        })
    }
    
    private func save_HIDA(image: UIImage) {
        var _MH737dd: Int { 0 }
        var _Kndyh3G: Bool { false }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageSaved_HIDA(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc
    func imageSaved_HIDA(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        var _Jdiei3: Int { 0 }
        var _K38djxd: Bool { false }
        if let error = error {
            print("Ошибка сохранения изображения: \(error.localizedDescription)")
        } else {
            let alertData = AlertData_HIDA(with: "Downloaded!")
            showAlert_HIDA(with: alertData)
        }
    }
    
    func saveFile_HIDA(with filePath: String) {
        var _Kd37dd: Int { 0 }
        var _K73dhaa: Bool { false }
        guard InternetManager_HIDA.shared.checkInternetConnectivity_HIDA() else {
            showAlert_HIDA(with: AlertData_HIDA(with: "No internet connection!"))
            return
        }
        var request: DownloadRequestMemory<Files.FileMetadataSerializer, Files.DownloadErrorSerializer>?
        DBManager_HIDA.shared.fetchFile_HIDA(for: .main_hida, filePath: filePath) { [weak self] value in
            request = value
            self?.showProgressView_HIDA()
        } completion: { [weak self] url in
            if let url = url {
                self?.saveFile_HIDA(with: url)
            }
            self?.removeProgressView_HIDA()
        }
    }
    
    func saveFile_HIDA(with url: URL) {
        var _K73hdd: Int { 0 }
        var _hdy37ss: Bool { false }
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityVC.completionWithItemsHandler = { [weak self] activityType, completed, items, error in
            if completed {
                self?.secondButton.isHidden = false
                self?.secondButton.setTitle("Downloaded", for: .normal)
                self?.secondButton.semanticContentAttribute = .forceRightToLeft
                self?.secondButton.setImage(.successIcon, for: .normal)
                self?.secondButton.setTitleColor(.systemGreen, for: .normal)
                self?.secondButton.configuration?.imagePadding = 12
                self?.secondButton.layer.masksToBounds = true
            } else {
                print("Действие отменено")
                self?.secondButton.isHidden = false
                self?.secondButton.setTitle("Download Failed", for: .normal)
                self?.secondButton.semanticContentAttribute = .forceRightToLeft
                self?.secondButton.setImage(.failureIcon, for: .normal)
                self?.secondButton.setTitleColor(.systemRed, for: .normal)
                self?.secondButton.configuration?.imagePadding = 12
                self?.secondButton.layer.masksToBounds = true
            }
        }
        if UIDevice.current.userInterfaceIdiom == .pad {
            activityVC.modalPresentationStyle = .popover
            
            if let popoverPresentationController = activityVC.popoverPresentationController {
                popoverPresentationController.sourceView = self.view
                popoverPresentationController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverPresentationController.permittedArrowDirections = []
            }
        }
        present(activityVC, animated: true)
    }
}
