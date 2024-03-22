//
//  CharacterListViewController_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

class CharacterListViewController_HIDA: UIViewController {
    
    @IBOutlet private weak var navigationView_HIDA: NavigationView_HIDA!
    @IBOutlet weak var imageView_HIDA: UIImageView!
    @IBOutlet weak var leftButton_HIDA: UIButton!
    @IBOutlet weak var rightButton_HIDA: UIButton!
    @IBOutlet weak var addNewButton_HIDA: UIButton!
    @IBOutlet weak var addNewButtonTopConstraint_HIDA: NSLayoutConstraint!
    @IBOutlet weak var addNewButtonHeight_HIDA: NSLayoutConstraint!
    @IBOutlet weak var rightIndentConstraint_HIDA: NSLayoutConstraint!
    @IBOutlet weak var leftIndentConstraint_HIDA: NSLayoutConstraint!
    
    @IBOutlet weak var topConstraint_HIDA: NSLayoutConstraint!
    
    private var dropbox_HIDA: DBManager_HIDA { .shared }
    private var editorContentSet_HIDA: EditorContentSet_HIDA?
    private var characters_HIDA: [CharacterPreview_HIDA] = []
    private var currentPage_HIDA = 0
    
    var toggleMenuAction_HIDA: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var _ecvbyss: Int { 0 }
        var _wetgt: Bool { true }
        loadCharacters_HIDA()
        loadContent_HIDA()
        configureLayout_HIDA()
        configureNavigationView_HIDA()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func configureLayout_HIDA() {
        let deviceType = UIDevice.current.userInterfaceIdiom
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = addNewButton_HIDA.bounds
        gradientLayer.colors = [
            UIColor(red: 0.37, green: 0.36, blue: 1, alpha: 1).cgColor,
            UIColor(red: 0.96, green: 0.27, blue: 0.95, alpha: 1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        addNewButton_HIDA.layer.insertSublayer(gradientLayer, at: 0)
        addNewButton_HIDA.layer.cornerRadius = 16
        rightIndentConstraint_HIDA.constant = deviceType == .phone ? 20 : 85
        leftIndentConstraint_HIDA.constant = deviceType == .phone ? 20 : 85
        topConstraint_HIDA.constant = deviceType == .phone ? 58 : 97
        addNewButtonTopConstraint_HIDA.constant = deviceType == .phone ? -16 : -43
        rightButton_HIDA.layer.cornerRadius = 8
        rightButton_HIDA.backgroundColor = .white.withAlphaComponent(0.56)
        leftButton_HIDA.layer.cornerRadius = 8
        leftButton_HIDA.backgroundColor = .white.withAlphaComponent(0.56)
        
        let fontSize: CGFloat = deviceType == .phone ? 20 : 32
        addNewButton_HIDA.titleLabel?.font =  UIFont(name: "BakbakOne-Regular", size: fontSize)!
    }
    
    private func updateCharImageView_HIDA() {
        navigationView_HIDA.build_HIDA(with: "Editor", rightIcon: characters_HIDA.isEmpty ? nil : UIImage(.deleteIcon))
        
        if characters_HIDA.indices.contains(currentPage_HIDA) {
            imageView_HIDA.image = characters_HIDA[currentPage_HIDA].image
        } else {
            imageView_HIDA.image = nil
        }
        
        if characters_HIDA.isEmpty {
            leftButton_HIDA.isHidden = true
            rightButton_HIDA.isHidden = true
        } else {
            leftButton_HIDA.isHidden = currentPage_HIDA == 0 ? true : false
            rightButton_HIDA.isHidden = currentPage_HIDA >= characters_HIDA.count-1 ? true : false
        }
    }
    
    @IBAction func imageTapped_HIDA(_ sender: UIButton) {
        guard let editorContentSet = editorContentSet_HIDA,
              characters_HIDA.indices.contains(currentPage_HIDA) else { return }
        let vc = CharacterEditorViewController_HIDA.loadFromNib_HIDA()
        vc.editorContentSet_HIDA = editorContentSet
        vc.characterPreview_HIDA = characters_HIDA[currentPage_HIDA]
        vc.addNewCharAction_HIDA = { [weak self] character in
            self?.add_HIDA(character: character)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addNewButtonDidTap_HIDA(_ sender: UIButton) {
        guard let editorContentSet = editorContentSet_HIDA else { return }
        let vc = CharacterEditorViewController_HIDA.loadFromNib_HIDA()
        vc.editorContentSet_HIDA = editorContentSet
        vc.addNewCharAction_HIDA = { [weak self] character in
            self?.add_HIDA(character: character)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func add_HIDA(character: CharacterPreview_HIDA) {
        if let index = characters_HIDA.firstIndex(where: { $0.id == character.id }) {
            characters_HIDA[index] = character
        } else {
            characters_HIDA.append(character)
            let charactersCount = characters_HIDA.count
            currentPage_HIDA = charactersCount-1
        }
        updateCharImageView_HIDA()
    }
    
    private func deleteButtonDidTap_HIDA() {
        guard !characters_HIDA.isEmpty else { return }
        let alertData = AlertData_HIDA(with: "ARE YOU SURE?",
                                  subtitle: "This will be delete all changes.",
                                  leftBtnText: "No",
                                  rightBtnText: "Delete") { [weak self] in
            self?.deleteCharacter_HIDA()
        }
        showAlert_HIDA(with: alertData)
    }
    
    private func deleteCharacter_HIDA() {
        guard !characters_HIDA.isEmpty, characters_HIDA.indices.contains(currentPage_HIDA) else { return }
        let character = characters_HIDA[currentPage_HIDA]
        dropbox_HIDA.contentManager.delete_HIDA(character: character)
        characters_HIDA.remove(at: currentPage_HIDA)
        currentPage_HIDA = characters_HIDA.count > 0 ? characters_HIDA.count - 1 : 0
        updateCharImageView_HIDA()
    }
    
    private func configureNavigationView_HIDA() {
        navigationView_HIDA.build_HIDA(with: "Editor", rightIcon: characters_HIDA.isEmpty ? nil : UIImage(.deleteIcon))
        navigationView_HIDA.rightButtonAction_HIDA = { [weak self] in
            self?.deleteButtonDidTap_HIDA()
        }
        navigationView_HIDA.leftButtonAction_HIDA = { [weak self] in
            self?.toggleMenuAction_HIDA?()
        }
    }
    
    @IBAction func leftButtonDidTap_HIDA(_ sender: UIButton) {
        guard currentPage_HIDA > 0 else { return }
        currentPage_HIDA -= 1
        updateCharImageView_HIDA()
    }
    
    @IBAction func rightButtonDidTap_HIDA(_ sender: UIButton) {
        guard currentPage_HIDA < characters_HIDA.count-1 else { return }
        currentPage_HIDA += 1
        updateCharImageView_HIDA()
    }
}

extension CharacterListViewController_HIDA {
    func loadCharacters_HIDA() {
        characters_HIDA = dropbox_HIDA.contentManager.fetchCharacters_HIDA()
        updateCharImageView_HIDA()
    }
    
    func loadContent_HIDA() {
        dropbox_HIDA.fetchEditorContent_HIDA(vc: self) { [weak self] editorContentSet in
            DispatchQueue.main.async {
                self?.removeProgressView_HIDA()
                self?.editorContentSet_HIDA = editorContentSet
                self?.loadStartContent_HIDA()
            }
        }
    }
    
    func loadStartContent_HIDA() {
        editorContentSet_HIDA?.contentTypes.forEach { [weak self] type in
            if let model = self?.editorContentSet_HIDA?.getModels(for: type)?.first {
                UIImageView.uploadPDF_HIDA(image: model.path.pdfPath)
            }
        }
    }
}