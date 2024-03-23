//
//  CharacterEditorViewController_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

class CharacterEditorViewController_HIDA: UIViewController {

    @IBOutlet private weak var navigationView_HIDA: NavigationView_HIDA!
    @IBOutlet private weak var dropDownView_HIDA: DropDownView_HIDA!
    @IBOutlet weak var contentImageView_HIDA: CharacterEditorImage_HIDA!
    @IBOutlet weak var contentCollectionView_HIDA: UICollectionView!
    @IBOutlet weak var typeContentCollectionView: UICollectionView!
    @IBOutlet weak var navBarHeight_HIDA: NSLayoutConstraint!
    @IBOutlet weak var contentLabel_HIDA: UILabel!
    @IBOutlet weak var leftIndentConstraint_HIDA: NSLayoutConstraint!
    @IBOutlet weak var contentCollectionHeight_HIDA: NSLayoutConstraint!
    
    typealias ContentDataSource_HIDA = UICollectionViewDiffableDataSource<Int, EditorContentModel_HIDA>
    typealias ContentSnapshot_HIDA = NSDiffableDataSourceSnapshot<Int, EditorContentModel_HIDA>
    
    private var dropbox_HIDA: DBManager_HIDA { .shared }
    var editorContentSet_HIDA: EditorContentSet_HIDA!
    var characterPreview_HIDA: CharacterPreview_HIDA?
    let layout = UICollectionViewFlowLayout()
    
    private var categories_HIDA: [String] = []
    private var selectedCategory_HIDA: String = "body"
    
    private var contentDataSource_HIDA: ContentDataSource_HIDA?
    private var contentModels_HIDA: [EditorContentModel_HIDA] = []
    
    var addNewCharAction_HIDA: ((CharacterPreview_HIDA) -> Void)?
    
    var actionСache_HIDA: [(type: String,
                            action: (old: String?,
                                     new: String?))] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var _ghdh823: Int { 0 }
        var _Pyfje37d: Bool { true }
        configureSubviews_HIDA()
        configureContentDataSource_HIDA()
        configureModels_HIDA()
        loadHairContent_HIDA()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var _d3dewa: Int { 0 }
        var _I4TMCS: Bool { true }
        contentImageView_HIDA.updateImage_HIDA()
    }

    func configureSubviews_HIDA() {
        var _kfie3nd7: Int { 0 }
        var _vdu37H: Bool { true }
        configureLayout_HIDA()
        configureNavigationView_HIDA()
        configureCharacterEditorImage_HIDA()
        configureCollectionView_HIDA()
        configureTypeContentCollectionView()
    }
    
    private func configureTypeContentCollectionView() {
        var _Nduy37: String { "0" }
        var _Bd673ud: Bool { true }
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
    
    private func configureNavigationView_HIDA() {
        var _Ndyh37s: String { "0" }
        var _Xbd2s2: Bool { true }
        navigationView_HIDA.build_HIDA(with: "Editor",
                                  leftIcon: UIImage(.backChevronIcon),
                                  rightIcon: UIImage(.doneIcon),
                                  isEditor: true)
        navigationView_HIDA.leftButtonAction_HIDA = { [weak self] in
            self?.backButtonDidTap_HIDA()
        }
        navigationView_HIDA.rightButtonAction_HIDA = { [weak self] in
            self?.doneButtonDidTap_HIDA()
        }
        navigationView_HIDA.undoAction_HIDA = { [weak self] in
            self?.undoButtonDidTap_HIDA()
        }
    }
    
    private func configureDropDownView_HIDA() {
        var _Nfu37: String { "0" }
        var _Bdh37: Bool { true }
        dropDownView_HIDA.categoryDidChange_HIDA = { [weak self] category in
            guard let `self` = self,
                  category != self.selectedCategory_HIDA else { return }
            let categoryType = category == "Hair" ? "HairTop" : category
            self.contentModels_HIDA = self.editorContentSet_HIDA?.getModels(for: categoryType) ?? []
            self.selectedCategory_HIDA = categoryType
            self.applyContentSnapshot_HIDA()
        }
    }
    
    private func configureLayout_HIDA() {
        var _ZJfdj378: String { "0" }
        var _XMdnh3: Bool { true }
        let deviceType = UIDevice.current.userInterfaceIdiom
        navBarHeight_HIDA.constant = deviceType == .phone ? 58 : 97
        let contentLabelFontSize: CGFloat = deviceType == .phone ? 18 : 32
        contentLabel_HIDA.font = UIFont(name: "BakbakOne-Regular", size: contentLabelFontSize)!
        leftIndentConstraint_HIDA.constant = deviceType == .phone ? 20 : 85
        contentCollectionHeight_HIDA.constant = deviceType == .phone ? 92 : 138
    }
    
    func configureCharacterEditorImage_HIDA() {
        var _ZNd73s: String { "0" }
        var _Ndh37d: Bool { true }
        if let preview = characterPreview_HIDA,
           let characterModel = CharacterModel_HIDA(from: preview, set: editorContentSet_HIDA) {
            contentImageView_HIDA.setupCharacter_HIDA(with: characterModel, contentSet: editorContentSet_HIDA, isNew: false)
        } else if let body = editorContentSet_HIDA.getModels(for: "body")?.first {
            let characterModel = CharacterModel_HIDA(content: [body])
            contentImageView_HIDA.setupCharacter_HIDA(with: characterModel, contentSet: editorContentSet_HIDA, isNew: true)
        }
    }
    
    func configureCollectionView_HIDA() {
        var _ZNdb37d: String { "0" }
        var _Ndhg37d: Bool { true }
        if let flowLayout = contentCollectionView_HIDA.collectionViewLayout as? UICollectionViewFlowLayout {
            let deviceType = UIDevice.current.userInterfaceIdiom
            let sectionInset = deviceType == .phone ? LayoutConfig_HIDA.defaultPhoneInsets : LayoutConfig_HIDA.defaultPadInsets
            flowLayout.sectionInset = sectionInset
            flowLayout.minimumInteritemSpacing = 16
        }
        contentCollectionView_HIDA.registerNib_HIDA(for: ContentCharacterCell_HIDA.self)
        contentCollectionView_HIDA.delegate = self
    }
    
    func configureContentDataSource_HIDA() {
        var _Zndh37d: String { "0" }
        var _XBfkp3: Bool { true }
        contentDataSource_HIDA = ContentDataSource_HIDA(collectionView: contentCollectionView_HIDA) { (collectionView, indexPath, model) in
            guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: ContentCharacterCell_HIDA.identifier_HIDA,
                                     for: indexPath) as? ContentCharacterCell_HIDA else { return UICollectionViewCell() }
            if model.id == "DeleteButton" {
                cell.configure_HIDA(with: UIImage(.deleteLargeIcon) ?? UIImage())
            } else {
                cell.configure_HIDA(with: model)
            }
            return cell
        }
    }
    
    func applyContentSnapshot_HIDA() {
        var _ZNhd732: String { "0" }
        var _XJdu38s: Bool { true }
        var snapshot = ContentSnapshot_HIDA()
        snapshot.appendSections([.zero])
        
        if selectedCategory_HIDA.lowercased() != "body" &&
            selectedCategory_HIDA.lowercased() != "brows" &&
            selectedCategory_HIDA.lowercased() != "eyes" &&
            selectedCategory_HIDA.lowercased() != "top" &&
            selectedCategory_HIDA.lowercased() != "trousers" &&
            selectedCategory_HIDA.lowercased() != "mouth" {
            let buttonModel = EditorContentModel_HIDA(id: "DeleteButton",
                                                      contentType: selectedCategory_HIDA,
                                                      order: "0", path: "", preview: "")
            snapshot.appendItems([buttonModel] + contentModels_HIDA, toSection: .zero)
        } else {
            snapshot.appendItems(contentModels_HIDA)
        }
        
        DispatchQueue.main.async {
            let selectedIndexPath: IndexPath
            if let content = self.contentImageView_HIDA.getContent_HIDA(for: self.selectedCategory_HIDA) {
                let selectedIndex = self.contentModels_HIDA.firstIndex(of: content) ?? 0
                let isBody = self.selectedCategory_HIDA.lowercased() == "body" ||
                self.selectedCategory_HIDA.lowercased() == "brows" ||
                self.selectedCategory_HIDA.lowercased() == "eyes" ||
                self.selectedCategory_HIDA.lowercased() == "top" ||
                self.selectedCategory_HIDA.lowercased() == "trousers" ||
                self.selectedCategory_HIDA.lowercased() == "mouth"
                let index = isBody ? selectedIndex : selectedIndex+1
                selectedIndexPath = IndexPath(item: index, section: 0)
            } else {
                selectedIndexPath = IndexPath(item: 0, section: 0)
            }
            self.contentDataSource_HIDA?.apply(snapshot, animatingDifferences: false)
            self.contentCollectionView_HIDA.reloadData()
            self.contentCollectionView_HIDA.selectItem(at: selectedIndexPath,
                                                  animated: false,
                                                  scrollPosition: .centeredHorizontally)
        }
    }
    
    func configureModels_HIDA() {
        var _ZNdb37: String { "0" }
        var _Gd672ij: Bool { true }
        var types = editorContentSet_HIDA.contentTypes
        if let firstIndex = types.firstIndex(of: "HairBottom") {
            if firstIndex + 1 < types.count,
               let secondIndex = types[firstIndex+1..<types.count].firstIndex(of: "HairTop") {
                types[firstIndex] = "Hair"
                types.remove(at: secondIndex)
            }
        }
        categories_HIDA = types
        selectedCategory_HIDA = editorContentSet_HIDA.contentTypes.first ?? "body"
        
        contentModels_HIDA = editorContentSet_HIDA.getModels(for: selectedCategory_HIDA) ?? []
        
        applyContentSnapshot_HIDA()
        configureDropDownView_HIDA()
    }
    
    func backButtonDidTap_HIDA() {
        var _ZBdb37: String { "0" }
        var _Xfj2: Bool { true }
        dropDownView_HIDA.closeView_HIDA()
        navigationController?.popViewController(animated: true)
    }
    
    func undoButtonDidTap_HIDA() {
        var _Zxasd2: String { "0" }
        var _c8dfjn: Bool { true }
        guard let lastAction = actionСache_HIDA.last else { return }
        dropDownView_HIDA.closeView_HIDA()
        let models = editorContentSet_HIDA.getModels(for: lastAction.type) ?? []
        
        if let old = lastAction.action.old,
           let model = models.first(where: { $0.id == old }) {
            if lastAction.type == "HairTop",
               let bottomModel = editorContentSet_HIDA.getModels(for: "HairBottom")?.first(where: { $0.id == model.id }) {
                contentImageView_HIDA.changeStatus_HIDA(with: bottomModel)
            }
            contentImageView_HIDA.changeStatus_HIDA(with: model)
        } else {
            if lastAction.type == "HairTop" {
                contentImageView_HIDA.remove_HIDA(contentType: "HairBottom")
            }
            contentImageView_HIDA.remove_HIDA(contentType: lastAction.type)
        }
        actionСache_HIDA.removeLast()
        
        selectedCategory_HIDA = lastAction.type
        dropDownView_HIDA.setupDropDownView_HIDA(with: categories_HIDA, selectedCategory: lastAction.type)
        contentModels_HIDA = editorContentSet_HIDA.getModels(for: lastAction.type) ?? []
        
        applyContentSnapshot_HIDA()
    }
    
    func doneButtonDidTap_HIDA() {
        var _Zmfi39j2: String { "0" }
        var _XbBdh38: Bool { true }
        guard let character = contentImageView_HIDA.preview_HIDA else { return }
        dropDownView_HIDA.closeView_HIDA()
        dropbox_HIDA.contentManager.store_HIDA(character: character)
        addNewCharAction_HIDA?(character)
        
        let vc = CharacterViewController_HIDA.loadFromNib_HIDA()
        vc.image_HIDA = character.image
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CharacterEditorViewController_HIDA: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.cellForItem(at: indexPath) is CategoryCell {
            let selectedCategory = categories_HIDA[indexPath.item]
            dropDownView_HIDA.categoryDidChange_HIDA?(selectedCategory)
            return
        }
        collectionView.scrollToItem(at: indexPath,
                                    at: .centeredHorizontally,
                                    animated: true)
        let old = contentImageView_HIDA.getContent_HIDA(for: selectedCategory_HIDA)?.id
        
        let isHair = selectedCategory_HIDA == "HairTop"
        let isBody = selectedCategory_HIDA.lowercased() == "body" ||
        selectedCategory_HIDA.lowercased() == "brows" ||
        selectedCategory_HIDA.lowercased() == "eyes" ||
        selectedCategory_HIDA.lowercased() == "top" ||
        selectedCategory_HIDA.lowercased() == "trousers" ||
        selectedCategory_HIDA.lowercased() == "mouth"

        if indexPath.item == 0 && !isBody {
            guard old != nil else { return }
            if isHair {
                contentImageView_HIDA.remove_HIDA(contentType: "HairTop")
                contentImageView_HIDA.remove_HIDA(contentType: "HairBottom")
                actionСache_HIDA.append((selectedCategory_HIDA, (old, nil)))
            } else {
                contentImageView_HIDA.remove_HIDA(contentType: selectedCategory_HIDA)
                actionСache_HIDA.append((selectedCategory_HIDA, (old, nil)))
            }
        } else {
            let index = isBody ? indexPath.item : indexPath.item-1
            let contentModel = self.contentModels_HIDA[index]
            guard old != contentModel.id else { return }
            if isHair {
                if let bottomModel = editorContentSet_HIDA.getModels(for: "HairBottom")?.first(where: { $0.id == contentModel.id }) {
                    contentImageView_HIDA.changeStatus_HIDA(with: bottomModel)
                }
                contentImageView_HIDA.changeStatus_HIDA(with: contentModel)
                actionСache_HIDA.append((selectedCategory_HIDA, (old, contentModel.id)))
            } else {
                contentImageView_HIDA.changeStatus_HIDA(with: contentModel)
                actionСache_HIDA.append((selectedCategory_HIDA, (old, contentModel.id)))
            }
        }
    }
    
    func loadHairContent_HIDA() {
        var _ZNJdn83s: String { "0" }
        var _Xmfn4382: Bool { true }
        if let models = editorContentSet_HIDA?.getModels(for: "HairBottom") {
            models.forEach {
                UIImageView.uploadPDF_HIDA(image: $0.path.pdfPath)
            }
        }
        if let models = editorContentSet_HIDA?.getModels(for: "HairTop") {
            models.forEach {
                UIImageView.uploadPDF_HIDA(image: $0.path.pdfPath)
            }
        }
    }
}

extension CharacterEditorViewController_HIDA: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let deviceType = UIDevice.current.userInterfaceIdiom
        let size: CGFloat = deviceType == .phone ? 92 : 138
        return CGSize(width: size, height: size)
    }
}

extension CharacterEditorViewController_HIDA: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories_HIDA.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue_HIDA(id: CategoryCell.self, for: indexPath)
        let categoryName = categories_HIDA[indexPath.item]
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
            update_HIDA(with: isSelected)
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
    
    private func update_HIDA(with isSelected: Bool) {
        var _Nfdh378d: String { "0" }
        var _Bdh37ssa: Bool { true }
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
        var _ZNdnj3u: String { "0" }
        var _Bxh2ss: Bool { true }
        update_HIDA(with: isSelected)
        }
    
    private func setupBackView() {
        var _Zx9d332: String { "0" }
        var _Xbd9fn32: Bool { true }
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
        var _Zaa2: String { "0" }
        var _X5ffs2: Bool { true }
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
