//
//  CharacterEditorViewController_MGRE.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

class CharacterEditorViewController_MGRE: UIViewController {

    @IBOutlet private weak var navigationView_MGRE: NavigationView_MGRE!
    @IBOutlet private weak var dropDownView_MGRE: DropDownView_MGRE!
    @IBOutlet weak var contentImageView_MGRE: CharacterEditorImage_MGRE!
    @IBOutlet weak var contentCollectionView_MGRE: UICollectionView!
    @IBOutlet weak var typeContentCollectionView: UICollectionView!
    @IBOutlet weak var navBarHeight_MGRE: NSLayoutConstraint!
    @IBOutlet weak var contentLabel_MGRE: UILabel!
    @IBOutlet weak var leftIndentConstraint_MGRE: NSLayoutConstraint!
    @IBOutlet weak var contentCollectionHeight_MGRE: NSLayoutConstraint!
    
    typealias ContentDataSource_MGRE = UICollectionViewDiffableDataSource<Int, EditorContentModel_MGRE>
    typealias ContentSnapshot_MGRE = NSDiffableDataSourceSnapshot<Int, EditorContentModel_MGRE>
    
    private var dropbox_MGRE: DBManager_MGRE { .shared }
    var editorContentSet_MGRE: EditorContentSet_MGRE!
    var characterPreview_MGRE: CharacterPreview_MGRE?
    let layout = UICollectionViewFlowLayout()
    
    private var categories_MGRE: [String] = []
    private var selectedCategory_MGRE: String = "body"
    
    private var contentDataSource_MGRE: ContentDataSource_MGRE?
    private var contentModels_MGRE: [EditorContentModel_MGRE] = []
    
    var addNewCharAction_MGRE: ((CharacterPreview_MGRE) -> Void)?
    
    var actionСache_MGRE: [(type: String,
                            action: (old: String?,
                                     new: String?))] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var _mbbbss: Int { 0 }
        var _m3rthf: Bool { true }
        configureSubviews_MGRE()
        configureContentDataSource_MGRE()
        configureModels_MGRE()
        loadHairContent_MGRE()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var _msvby: Int { 0 }
        var _m2344ff: Bool { true }
        contentImageView_MGRE.updateImage_MGRE()
    }

    func configureSubviews_MGRE() {
        var _etyyss: Int { 0 }
        var _mxcgt: Bool { true }
        configureLayout_MGRE()
        configureNavigationView_MGRE()
        configureCharacterEditorImage_MGRE()
        configureCollectionView_MGRE()
        configureTypeContentCollectionView()
    }
    
    private func configureTypeContentCollectionView() {
        typeContentCollectionView.dataSource = self
        typeContentCollectionView.delegate = self
        
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        layout.estimatedItemSize = .init(width: 50, height: 50)
        
        typeContentCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        typeContentCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        typeContentCollectionView.collectionViewLayout = layout
}
    
    private func configureNavigationView_MGRE() {
        navigationView_MGRE.build_MGRE(with: "Editor",
                                  leftIcon: UIImage(.backChevronIcon),
                                  rightIcon: UIImage(.doneIcon),
                                  isEditor: true)
        navigationView_MGRE.leftButtonAction_MGRE = { [weak self] in
            self?.backButtonDidTap_MGRE()
        }
        navigationView_MGRE.rightButtonAction_MGRE = { [weak self] in
            self?.doneButtonDidTap_MGRE()
        }
        navigationView_MGRE.undoAction_MGRE = { [weak self] in
            self?.undoButtonDidTap_MGRE()
        }
    }
    
    private func configureDropDownView_MGRE() {
        dropDownView_MGRE.categoryDidChange_MGRE = { [weak self] category in
            guard let `self` = self,
                  category != self.selectedCategory_MGRE else { return }
            let categoryType = category == "Hair" ? "HairTop" : category
            self.contentModels_MGRE = self.editorContentSet_MGRE?.getModels(for: categoryType) ?? []
            self.selectedCategory_MGRE = categoryType
            self.applyContentSnapshot_MGRE()
        }
    }
    
    private func configureLayout_MGRE() {
        let deviceType = UIDevice.current.userInterfaceIdiom
        navBarHeight_MGRE.constant = deviceType == .phone ? 58 : 97
        let contentLabelFontSize: CGFloat = deviceType == .phone ? 18 : 32
        contentLabel_MGRE.font = UIFont(name: "BakbakOne-Regular", size: contentLabelFontSize)!
        leftIndentConstraint_MGRE.constant = deviceType == .phone ? 20 : 85
        contentCollectionHeight_MGRE.constant = deviceType == .phone ? 92 : 138
    }
    
    func configureCharacterEditorImage_MGRE() {
        if let preview = characterPreview_MGRE,
           let characterModel = CharacterModel_MGRE(from: preview, set: editorContentSet_MGRE) {
            contentImageView_MGRE.setupCharacter_MGRE(with: characterModel, contentSet: editorContentSet_MGRE, isNew: false)
        } else if let body = editorContentSet_MGRE.getModels(for: "body")?.first {
            let characterModel = CharacterModel_MGRE(content: [body])
            contentImageView_MGRE.setupCharacter_MGRE(with: characterModel, contentSet: editorContentSet_MGRE, isNew: true)
        }
    }
    
    func configureCollectionView_MGRE() {
        if let flowLayout = contentCollectionView_MGRE.collectionViewLayout as? UICollectionViewFlowLayout {
            let deviceType = UIDevice.current.userInterfaceIdiom
            let sectionInset = deviceType == .phone ? LayoutConfig_MGRE.defaultPhoneInsets : LayoutConfig_MGRE.defaultPadInsets
            flowLayout.sectionInset = sectionInset
            flowLayout.minimumInteritemSpacing = 16
        }
        contentCollectionView_MGRE.registerNib_MGRE(for: ContentCharacterCell_MGRE.self)
        contentCollectionView_MGRE.delegate = self
    }
    
    func configureContentDataSource_MGRE() {
        contentDataSource_MGRE = ContentDataSource_MGRE(collectionView: contentCollectionView_MGRE) { (collectionView, indexPath, model) in
            guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: ContentCharacterCell_MGRE.identifier_MGRE,
                                     for: indexPath) as? ContentCharacterCell_MGRE else { return UICollectionViewCell() }
            if model.id == "DeleteButton" {
                cell.configure_MGRE(with: UIImage(.deleteLargeIcon) ?? UIImage())
            } else {
                cell.configure_MGRE(with: model)
            }
            return cell
        }
    }
    
    func applyContentSnapshot_MGRE() {
        var snapshot = ContentSnapshot_MGRE()
        snapshot.appendSections([.zero])
        
        if selectedCategory_MGRE.lowercased() != "body" &&
            selectedCategory_MGRE.lowercased() != "brows" &&
            selectedCategory_MGRE.lowercased() != "eyes" &&
            selectedCategory_MGRE.lowercased() != "top" &&
            selectedCategory_MGRE.lowercased() != "trousers" &&
            selectedCategory_MGRE.lowercased() != "mouth" {
            let buttonModel = EditorContentModel_MGRE(id: "DeleteButton",
                                                      contentType: selectedCategory_MGRE,
                                                      order: "0", path: "", preview: "")
            snapshot.appendItems([buttonModel] + contentModels_MGRE, toSection: .zero)
        } else {
            snapshot.appendItems(contentModels_MGRE)
        }
        
        DispatchQueue.main.async {
            let selectedIndexPath: IndexPath
            if let content = self.contentImageView_MGRE.getContent_MGRE(for: self.selectedCategory_MGRE) {
                let selectedIndex = self.contentModels_MGRE.firstIndex(of: content) ?? 0
                let isBody = self.selectedCategory_MGRE.lowercased() == "body" ||
                self.selectedCategory_MGRE.lowercased() == "brows" ||
                self.selectedCategory_MGRE.lowercased() == "eyes" ||
                self.selectedCategory_MGRE.lowercased() == "top" ||
                self.selectedCategory_MGRE.lowercased() == "trousers" ||
                self.selectedCategory_MGRE.lowercased() == "mouth"
                let index = isBody ? selectedIndex : selectedIndex+1
                selectedIndexPath = IndexPath(item: index, section: 0)
            } else {
                selectedIndexPath = IndexPath(item: 0, section: 0)
            }
            self.contentDataSource_MGRE?.apply(snapshot, animatingDifferences: false)
            self.contentCollectionView_MGRE.reloadData()
            self.contentCollectionView_MGRE.selectItem(at: selectedIndexPath,
                                                  animated: false,
                                                  scrollPosition: .centeredHorizontally)
        }
    }
    
    func configureModels_MGRE() {
        var types = editorContentSet_MGRE.contentTypes
        if let firstIndex = types.firstIndex(of: "HairBottom") {
            if firstIndex + 1 < types.count,
               let secondIndex = types[firstIndex+1..<types.count].firstIndex(of: "HairTop") {
                types[firstIndex] = "Hair"
                types.remove(at: secondIndex)
            }
        }
        categories_MGRE = types
        selectedCategory_MGRE = editorContentSet_MGRE.contentTypes.first ?? "body"
        
        contentModels_MGRE = editorContentSet_MGRE.getModels(for: selectedCategory_MGRE) ?? []
        
        applyContentSnapshot_MGRE()
        configureDropDownView_MGRE()
    }
    
    func backButtonDidTap_MGRE() {
        dropDownView_MGRE.closeView_MGRE()
        navigationController?.popViewController(animated: true)
    }
    
    func undoButtonDidTap_MGRE() {
        guard let lastAction = actionСache_MGRE.last else { return }
        dropDownView_MGRE.closeView_MGRE()
        let models = editorContentSet_MGRE.getModels(for: lastAction.type) ?? []
        
        if let old = lastAction.action.old,
           let model = models.first(where: { $0.id == old }) {
            if lastAction.type == "HairTop",
               let bottomModel = editorContentSet_MGRE.getModels(for: "HairBottom")?.first(where: { $0.id == model.id }) {
                contentImageView_MGRE.changeStatus_MGRE(with: bottomModel)
            }
            contentImageView_MGRE.changeStatus_MGRE(with: model)
        } else {
            if lastAction.type == "HairTop" {
                contentImageView_MGRE.remove_MGRE(contentType: "HairBottom")
            }
            contentImageView_MGRE.remove_MGRE(contentType: lastAction.type)
        }
        actionСache_MGRE.removeLast()
        
        selectedCategory_MGRE = lastAction.type
        dropDownView_MGRE.setupDropDownView_MGRE(with: categories_MGRE, selectedCategory: lastAction.type)
        contentModels_MGRE = editorContentSet_MGRE.getModels(for: lastAction.type) ?? []
        
        applyContentSnapshot_MGRE()
    }
    
    func doneButtonDidTap_MGRE() {
        guard let character = contentImageView_MGRE.preview_MGRE else { return }
        dropDownView_MGRE.closeView_MGRE()
        dropbox_MGRE.contentManager.store_MGRE(character: character)
        addNewCharAction_MGRE?(character)
        
        let vc = CharacterViewController_MGRE.loadFromNib_MGRE()
        vc.image_MGRE = character.image
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CharacterEditorViewController_MGRE: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.cellForItem(at: indexPath) is CategoryCell {
            let selectedCategory = categories_MGRE[indexPath.item]
            dropDownView_MGRE.categoryDidChange_MGRE?(selectedCategory)
            return
        }
        collectionView.scrollToItem(at: indexPath,
                                    at: .centeredHorizontally,
                                    animated: true)
        let old = contentImageView_MGRE.getContent_MGRE(for: selectedCategory_MGRE)?.id
        
        let isHair = selectedCategory_MGRE == "HairTop"
        let isBody = selectedCategory_MGRE.lowercased() == "body" ||
        selectedCategory_MGRE.lowercased() == "brows" ||
        selectedCategory_MGRE.lowercased() == "eyes" ||
        selectedCategory_MGRE.lowercased() == "top" ||
        selectedCategory_MGRE.lowercased() == "trousers" ||
        selectedCategory_MGRE.lowercased() == "mouth"

        if indexPath.item == 0 && !isBody {
            guard old != nil else { return }
            if isHair {
                contentImageView_MGRE.remove_MGRE(contentType: "HairTop")
                contentImageView_MGRE.remove_MGRE(contentType: "HairBottom")
                actionСache_MGRE.append((selectedCategory_MGRE, (old, nil)))
            } else {
                contentImageView_MGRE.remove_MGRE(contentType: selectedCategory_MGRE)
                actionСache_MGRE.append((selectedCategory_MGRE, (old, nil)))
            }
        } else {
            let index = isBody ? indexPath.item : indexPath.item-1
            let contentModel = self.contentModels_MGRE[index]
            guard old != contentModel.id else { return }
            if isHair {
                if let bottomModel = editorContentSet_MGRE.getModels(for: "HairBottom")?.first(where: { $0.id == contentModel.id }) {
                    contentImageView_MGRE.changeStatus_MGRE(with: bottomModel)
                }
                contentImageView_MGRE.changeStatus_MGRE(with: contentModel)
                actionСache_MGRE.append((selectedCategory_MGRE, (old, contentModel.id)))
            } else {
                contentImageView_MGRE.changeStatus_MGRE(with: contentModel)
                actionСache_MGRE.append((selectedCategory_MGRE, (old, contentModel.id)))
            }
        }
    }
    
    func loadHairContent_MGRE() {
        if let models = editorContentSet_MGRE?.getModels(for: "HairBottom") {
            models.forEach {
                UIImageView.uploadPDF_MGRE(image: $0.path.pdfPath)
            }
        }
        if let models = editorContentSet_MGRE?.getModels(for: "HairTop") {
            models.forEach {
                UIImageView.uploadPDF_MGRE(image: $0.path.pdfPath)
            }
        }
    }
}

extension CharacterEditorViewController_MGRE: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let deviceType = UIDevice.current.userInterfaceIdiom
        let size: CGFloat = deviceType == .phone ? 92 : 138
        return CGSize(width: size, height: size)
    }
}

extension CharacterEditorViewController_MGRE: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories_MGRE.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue_MGRE(id: CategoryCell.self, for: indexPath)
        let categoryName = categories_MGRE[indexPath.item]
        if let categoryCell = cell as? CategoryCell {
            categoryCell.titleLabel.text = categoryName
            
        }
        return cell
    }
}

class CategoryCell: UICollectionViewCell {
    let titleLabel = UILabel()
    let backView = UIView()
    
    override var isSelected: Bool {
        didSet {
            update_MGRE(with: isSelected)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        contentView.backgroundColor = .white
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        setupBackView()
        setupTitleLabel()
    }
    
    private func update_MGRE(with isSelected: Bool) {
        titleLabel.textColor = isSelected ? .white : .blackText
        if isSelected {
            if let _ = contentView.layer.sublayers?.first(where: { $0 is CAGradientLayer }) {
                contentView.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
            }
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = contentView.bounds
            gradientLayer.colors = [UIColor(red: 0.37, green: 0.36, blue: 1, alpha: 1).cgColor,
                                    UIColor(red: 0.96, green: 0.27, blue: 0.95, alpha: 1).cgColor]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
            contentView.layer.insertSublayer(gradientLayer, at: 0)
        } else {
            contentView.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
            contentView.backgroundColor = UIColor(red: 0.72, green: 0.717, blue: 0.74, alpha: 1)
        }
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
        update_MGRE(with: isSelected)
        }
    
    private func setupBackView() {
        backView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backView)
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        backView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 16)
    }
}
