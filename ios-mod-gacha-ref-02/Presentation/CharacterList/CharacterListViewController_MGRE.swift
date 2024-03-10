//
//  CharacterListViewController_MGRE.swift
//  ios-mod-gacha
//
//  Created by Andrii Bala on 9/28/23.
//

import UIKit

class CharacterListViewController_MGRE: UIViewController {
    
    @IBOutlet private weak var navigationView_MGRE: NavigationView_MGRE!
    @IBOutlet weak var imageView_MGRE: UIImageView!
    @IBOutlet weak var leftButton_MGRE: UIButton!
    @IBOutlet weak var rightButton_MGRE: UIButton!
    @IBOutlet weak var addNewButton_MGRE: UIButton!
    @IBOutlet weak var addNewButtonTopConstraint_MGRE: NSLayoutConstraint!
    @IBOutlet weak var addNewButtonHeight_MGRE: NSLayoutConstraint!
    @IBOutlet weak var rightIndentConstraint_MGRE: NSLayoutConstraint!
    @IBOutlet weak var leftIndentConstraint_MGRE: NSLayoutConstraint!
    
    @IBOutlet weak var topConstraint_MGRE: NSLayoutConstraint!
    
    private var dropbox_MGRE: DBManager_MGRE { .shared }
    private var editorContentSet_MGRE: EditorContentSet_MGRE?
    private var characters_MGRE: [CharacterPreview_MGRE] = []
    private var currentPage_MGRE = 0
    
    var toggleMenuAction_MGRE: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var _ecvbyss: Int { 0 }
        var _wetgt: Bool { true }
        loadCharacters_MGRE()
        loadContent_MGRE()
        configureLayout_MGRE()
        configureNavigationView_MGRE()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func configureLayout_MGRE() {
        let deviceType = UIDevice.current.userInterfaceIdiom
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = addNewButton_MGRE.bounds
        gradientLayer.colors = [
            UIColor(red: 0.37, green: 0.36, blue: 1, alpha: 1).cgColor,
            UIColor(red: 0.96, green: 0.27, blue: 0.95, alpha: 1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        addNewButton_MGRE.layer.insertSublayer(gradientLayer, at: 0)
        addNewButton_MGRE.layer.cornerRadius = 16
        rightIndentConstraint_MGRE.constant = deviceType == .phone ? 20 : 85
        leftIndentConstraint_MGRE.constant = deviceType == .phone ? 20 : 85
        topConstraint_MGRE.constant = deviceType == .phone ? 58 : 97
        addNewButtonTopConstraint_MGRE.constant = deviceType == .phone ? -16 : -43
        rightButton_MGRE.layer.cornerRadius = 8
        rightButton_MGRE.backgroundColor = .white.withAlphaComponent(0.56)
        leftButton_MGRE.layer.cornerRadius = 8
        leftButton_MGRE.backgroundColor = .white.withAlphaComponent(0.56)
        
        let fontSize: CGFloat = deviceType == .phone ? 20 : 32
        addNewButton_MGRE.titleLabel?.font =  UIFont(name: "BakbakOne-Regular", size: fontSize)!
    }
    
    private func updateCharImageView_MGRE() {
        navigationView_MGRE.build_MGRE(with: "Editor", rightIcon: characters_MGRE.isEmpty ? nil : UIImage(.deleteIcon))
        
        if characters_MGRE.indices.contains(currentPage_MGRE) {
            imageView_MGRE.image = characters_MGRE[currentPage_MGRE].image
        } else {
            imageView_MGRE.image = nil
        }
        
        if characters_MGRE.isEmpty {
            leftButton_MGRE.isHidden = true
            rightButton_MGRE.isHidden = true
        } else {
            leftButton_MGRE.isHidden = currentPage_MGRE == 0 ? true : false
            rightButton_MGRE.isHidden = currentPage_MGRE >= characters_MGRE.count-1 ? true : false
        }
    }
    
    @IBAction func imageTapped_MGRE(_ sender: UIButton) {
        guard let editorContentSet = editorContentSet_MGRE,
              characters_MGRE.indices.contains(currentPage_MGRE) else { return }
        let vc = CharacterEditorViewController_MGRE.loadFromNib_MGRE()
        vc.editorContentSet_MGRE = editorContentSet
        vc.characterPreview_MGRE = characters_MGRE[currentPage_MGRE]
        vc.addNewCharAction_MGRE = { [weak self] character in
            self?.add_MGRE(character: character)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addNewButtonDidTap_MGRE(_ sender: UIButton) {
        guard let editorContentSet = editorContentSet_MGRE else { return }
        let vc = CharacterEditorViewController_MGRE.loadFromNib_MGRE()
        vc.editorContentSet_MGRE = editorContentSet
        vc.addNewCharAction_MGRE = { [weak self] character in
            self?.add_MGRE(character: character)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func add_MGRE(character: CharacterPreview_MGRE) {
        if let index = characters_MGRE.firstIndex(where: { $0.id == character.id }) {
            characters_MGRE[index] = character
        } else {
            characters_MGRE.append(character)
            let charactersCount = characters_MGRE.count
            currentPage_MGRE = charactersCount-1
        }
        updateCharImageView_MGRE()
    }
    
    private func deleteButtonDidTap_MGRE() {
        guard !characters_MGRE.isEmpty else { return }
        let alertData = AlertData_MGRE(with: "ARE YOU SURE?",
                                  subtitle: "This will be delete all changes.",
                                  leftBtnText: "No",
                                  rightBtnText: "Delete") { [weak self] in
            self?.deleteCharacter_MGRE()
        }
        showAlert_MGRE(with: alertData)
    }
    
    private func deleteCharacter_MGRE() {
        guard !characters_MGRE.isEmpty, characters_MGRE.indices.contains(currentPage_MGRE) else { return }
        let character = characters_MGRE[currentPage_MGRE]
        dropbox_MGRE.contentManager.delete_MGRE(character: character)
        characters_MGRE.remove(at: currentPage_MGRE)
        currentPage_MGRE = characters_MGRE.count > 0 ? characters_MGRE.count - 1 : 0
        updateCharImageView_MGRE()
    }
    
    private func configureNavigationView_MGRE() {
        navigationView_MGRE.build_MGRE(with: "Editor", rightIcon: characters_MGRE.isEmpty ? nil : UIImage(.deleteIcon))
        navigationView_MGRE.rightButtonAction_MGRE = { [weak self] in
            self?.deleteButtonDidTap_MGRE()
        }
        navigationView_MGRE.leftButtonAction_MGRE = { [weak self] in
            self?.toggleMenuAction_MGRE?()
        }
    }
    
    @IBAction func leftButtonDidTap_MGRE(_ sender: UIButton) {
        guard currentPage_MGRE > 0 else { return }
        currentPage_MGRE -= 1
        updateCharImageView_MGRE()
    }
    
    @IBAction func rightButtonDidTap_MGRE(_ sender: UIButton) {
        guard currentPage_MGRE < characters_MGRE.count-1 else { return }
        currentPage_MGRE += 1
        updateCharImageView_MGRE()
    }
}

extension CharacterListViewController_MGRE {
    func loadCharacters_MGRE() {
        characters_MGRE = dropbox_MGRE.contentManager.fetchCharacters_MGRE()
        updateCharImageView_MGRE()
    }
    
    func loadContent_MGRE() {
        dropbox_MGRE.fetchEditorContent_MGRE(vc: self) { [weak self] editorContentSet in
            DispatchQueue.main.async {
                self?.removeProgressView_MGRE()
                self?.editorContentSet_MGRE = editorContentSet
                self?.loadStartContent_MGRE()
            }
        }
    }
    
    func loadStartContent_MGRE() {
        editorContentSet_MGRE?.contentTypes.forEach { [weak self] type in
            if let model = self?.editorContentSet_MGRE?.getModels(for: type)?.first {
                UIImageView.uploadPDF_MGRE(image: model.path.pdfPath)
            }
        }
    }
}
