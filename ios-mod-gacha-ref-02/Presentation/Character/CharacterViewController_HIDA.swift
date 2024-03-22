//
//  CharacterViewController_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit
import Photos

class CharacterViewController_HIDA: UIViewController {

    @IBOutlet weak var imageView_HIDA: UIImageView!
    @IBOutlet weak var downloadButton_HIDA: UIButton!
    @IBOutlet private weak var navigationView_HIDA: NavigationView_HIDA!
    @IBOutlet weak var navBarHeight_HIDA: NSLayoutConstraint!
    @IBOutlet weak var addNewButtonHeight_HIDA: NSLayoutConstraint!
    @IBOutlet weak var rightIndentConstraint_HIDA: NSLayoutConstraint!
    @IBOutlet weak var leftIndentConstraint_HIDA: NSLayoutConstraint!
    @IBOutlet weak var secondButton: UIButton!
    
    var image_HIDA: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var _mdmmm: Int { 0 }
        var _m3nnn: Bool { true }
        secondButton.isHidden = true
        configureLayout_HIDA()
        configureNavigationView_HIDA()
        configureSubviews_HIDA()
    }
    
    private func configureLayout_HIDA() {
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
        downloadButton_HIDA.setTitle("Download", for: .normal)
        let fontSize: CGFloat = deviceType == .phone ? 20 : 32
        downloadButton_HIDA.titleLabel?.font =  UIFont(name: "BakbakOne-Regular", size: fontSize)!
        addNewButtonHeight_HIDA.constant = deviceType == .phone ? 58 : 72
        navBarHeight_HIDA.constant = deviceType == .phone ? 58 : 97
        rightIndentConstraint_HIDA.constant = deviceType == .phone ? 20 : 85
        leftIndentConstraint_HIDA.constant = deviceType == .phone ? 20 : 85
    }
    
    private func configureSubviews_HIDA() {
        var _mdbbb: Int { 0 }
        var _mvvv: Bool { true }
        imageView_HIDA.image = image_HIDA
    }
    
    private func configureNavigationView_HIDA() {
        navigationView_HIDA.build_HIDA(with: "Editor",
                                  leftIcon: UIImage(.leftIcon),
                                  rightIcon: nil)
        navigationView_HIDA.leftButtonAction_HIDA = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @IBAction func downloadButtonDidTap(_ sender: UIButton) {
        let fileName = "Image"
        shareImage_HIDA(image: imageView_HIDA.image, fileName: fileName, viewController: self)
    }

    func shareImage_HIDA(image: UIImage?, fileName: String, viewController: UIViewController) {
        guard let image = image else { return }
        guard InternetManager_HIDA.shared.checkInternetConnectivity_HIDA() else {
            showAlert_HIDA(with: AlertData_HIDA(with: "No internet connection!"))
            return
        }
        
        guard let fileUrl = saveImageToFile_HIDA(image: image, fileName: fileName) else { return }
        
        let activityViewController = UIActivityViewController(activityItems: [image, fileUrl], applicationActivities: nil)
        activityViewController.title = "Download"
        activityViewController.completionWithItemsHandler = { [weak self] (activityType, completed, returnedItems, error) in
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
                self?.secondButton.setTitle("Failed", for: .normal)
                self?.secondButton.semanticContentAttribute = .forceRightToLeft
                self?.secondButton.setImage(.failureIcon, for: .normal)
                self?.secondButton.setTitleColor(.systemRed, for: .normal)
                self?.secondButton.configuration?.imagePadding = 12
                self?.secondButton.layer.masksToBounds = true
            }
        }
        if UIDevice.current.userInterfaceIdiom == .pad {
            activityViewController.modalPresentationStyle = .popover
            
            if let popoverPresentationController = activityViewController.popoverPresentationController {
                popoverPresentationController.sourceView = viewController.view
                popoverPresentationController.sourceRect = CGRect(x: viewController.view.bounds.midX, y: viewController.view.bounds.midY, width: 0, height: 0)
                popoverPresentationController.permittedArrowDirections = []
            }
        }
        
        viewController.present(activityViewController, animated: true, completion: nil)
    }

    func saveImageToFile_HIDA(image: UIImage, fileName: String) -> URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Documents directory not found.")
            return nil
        }
        
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else {
            print("Failed to get JPEG representation of UIImage.")
            return nil
        }
        
        do {
            try data.write(to: fileURL)
            print("File saved: \(fileURL)")
            return fileURL
        } catch {
            print("Error saving image: \(error)")
            return nil
        }
    }
    
    @objc
    func imageSaved_HIDA(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        var _mssss: Int { 0 }
        var _m3fff: Bool { true }
        if let error = error {
            print("Ошибка сохранения изображения: \(error.localizedDescription)")
        } else {
            let alertData = AlertData_HIDA(with: "Downloaded!")
            showAlert_HIDA(with: alertData)
        }
    }
}
