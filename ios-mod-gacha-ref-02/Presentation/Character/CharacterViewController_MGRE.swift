//
//  CharacterViewController_MGRE.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit
import Photos

class CharacterViewController_MGRE: UIViewController {

    @IBOutlet weak var imageView_MGRE: UIImageView!
    @IBOutlet weak var downloadButton_MGRE: UIButton!
    @IBOutlet private weak var navigationView_MGRE: NavigationView_MGRE!
    @IBOutlet weak var navBarHeight_MGRE: NSLayoutConstraint!
    @IBOutlet weak var addNewButtonHeight_MGRE: NSLayoutConstraint!
    @IBOutlet weak var rightIndentConstraint_MGRE: NSLayoutConstraint!
    @IBOutlet weak var leftIndentConstraint_MGRE: NSLayoutConstraint!
    @IBOutlet weak var secondButton: UIButton!
    
    var image_MGRE: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var _mdmmm: Int { 0 }
        var _m3nnn: Bool { true }
        secondButton.isHidden = true
        configureLayout_MGRE()
        configureNavigationView_MGRE()
        configureSubviews_MGRE()
    }
    
    private func configureLayout_MGRE() {
        let deviceType = UIDevice.current.userInterfaceIdiom
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = downloadButton_MGRE.bounds
        gradientLayer.colors = [
            UIColor(red: 0.37, green: 0.36, blue: 1, alpha: 1).cgColor,
            UIColor(red: 0.96, green: 0.27, blue: 0.95, alpha: 1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        downloadButton_MGRE.layer.insertSublayer(gradientLayer, at: 0)
        downloadButton_MGRE.layer.cornerRadius = 16
        downloadButton_MGRE.layer.masksToBounds = true
        downloadButton_MGRE.configuration?.imagePadding = 12
        downloadButton_MGRE.semanticContentAttribute = .forceRightToLeft
        downloadButton_MGRE.setImage(.downloadIcon, for: .normal)
        downloadButton_MGRE.setTitle("Download", for: .normal)
        let fontSize: CGFloat = deviceType == .phone ? 20 : 32
        downloadButton_MGRE.titleLabel?.font =  UIFont(name: "BakbakOne-Regular", size: fontSize)!
        addNewButtonHeight_MGRE.constant = deviceType == .phone ? 58 : 72
        navBarHeight_MGRE.constant = deviceType == .phone ? 58 : 97
        rightIndentConstraint_MGRE.constant = deviceType == .phone ? 20 : 85
        leftIndentConstraint_MGRE.constant = deviceType == .phone ? 20 : 85
    }
    
    private func configureSubviews_MGRE() {
        var _mdbbb: Int { 0 }
        var _mvvv: Bool { true }
        imageView_MGRE.image = image_MGRE
    }
    
    private func configureNavigationView_MGRE() {
        navigationView_MGRE.build_MGRE(with: "Editor",
                                  leftIcon: UIImage(.leftIcon),
                                  rightIcon: nil)
        navigationView_MGRE.leftButtonAction_MGRE = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @IBAction func downloadButtonDidTap(_ sender: UIButton) {
        let fileName = "Image"
        shareImage_MGRE(image: imageView_MGRE.image, fileName: fileName, viewController: self)
    }

    func shareImage_MGRE(image: UIImage?, fileName: String, viewController: UIViewController) {
        guard let image = image else { return }
        guard InternetManager_MGRE.shared.checkInternetConnectivity_MGRE() else {
            showAlert_MGRE(with: AlertData_MGRE(with: "No internet connection!"))
            return
        }
        
        guard let fileUrl = saveImageToFile_MGRE(image: image, fileName: fileName) else { return }
        
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

    func saveImageToFile_MGRE(image: UIImage, fileName: String) -> URL? {
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
    func imageSaved_MGRE(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        var _mssss: Int { 0 }
        var _m3fff: Bool { true }
        if let error = error {
            print("Ошибка сохранения изображения: \(error.localizedDescription)")
        } else {
            let alertData = AlertData_MGRE(with: "Downloaded!")
            showAlert_MGRE(with: alertData)
        }
    }
}
