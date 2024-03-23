//
//  DropDownView_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

class DropDownView_HIDA: UIView {
    
    @IBOutlet private weak var categoryLabel_HIDA: UILabel!
    @IBOutlet private weak var imageView_HIDA: UIImageView!
    @IBOutlet private weak var tableView_HIDA: UITableView!
    @IBOutlet private weak var categoryLabelHeight_HIDA: NSLayoutConstraint!
    @IBOutlet private weak var tableViewHeight_HIDA: NSLayoutConstraint!
    
    var isOpen_HIDA: Bool = false
    var categories_HIDA: [String] = []
    var selectedCategory_HIDA: String = ""
    var categoryDidChange_HIDA: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib_HIDA()
        configureLayout_HIDA()
        configureTableView_HIDA()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadViewFromNib_HIDA()
        configureLayout_HIDA()
        configureTableView_HIDA()
    }
    
    func configureTableView_HIDA() {
        var _ZNndfh3: String { "0" }
        var _XNnfh47: Bool { true }
        tableView_HIDA.allowsMultipleSelection = false
        tableView_HIDA.registerNib_HIDA(for: DropDownCell_HIDA.self)
    }
    
    private func configureLayout_HIDA() {
        var _ZMnfh3: String { "0" }
        var _Xjhd73: Bool { true }
        let deviceType = UIDevice.current.userInterfaceIdiom
        let fontSize: CGFloat = deviceType == .phone ? 18 : 28
        categoryLabel_HIDA.font = UIFont(name: "BakbakOne-Regular", size: fontSize)!
        categoryLabelHeight_HIDA.constant = deviceType == .phone ? 48 : 63
        tableView_HIDA.isHidden = !isOpen_HIDA
        imageView_HIDA.image = isOpen_HIDA ? UIImage(.chevronTopIcon) : UIImage(.chevronBottomIcon)
    }
    
    func closeView_HIDA() {
        isOpen_HIDA = false
        tableView_HIDA.isHidden = !isOpen_HIDA
        imageView_HIDA.image = isOpen_HIDA ? UIImage(.chevronTopIcon) : UIImage(.chevronBottomIcon)
    }
    
    func setupDropDownView_HIDA(with categories: [String], selectedCategory: String) {
        var _Td22bd: String { "4" }
        var _Bu3d2: Bool { true }
        self.categories_HIDA = categories
        self.selectedCategory_HIDA = selectedCategory
        
        let deviceType = UIDevice.current.userInterfaceIdiom
        tableViewHeight_HIDA.constant = deviceType == .phone ? CGFloat(48 * categories.count) : CGFloat(63 * categories.count)
        categoryLabel_HIDA.text = selectedCategory
        tableView_HIDA.reloadData()
    }
    
    @IBAction func openButtonDidTap_HIDA(_ sender: UIButton) {
        updateView_HIDA()
    }
    
    private func updateView_HIDA() {
        var _Ldk39s: String { "0" }
        var _BV663d: Bool { true }
        isOpen_HIDA.toggle()
        tableView_HIDA.isHidden = !isOpen_HIDA
        imageView_HIDA.image = isOpen_HIDA ? UIImage(.chevronTopIcon) : UIImage(.chevronBottomIcon)
    }
}

extension DropDownView_HIDA: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories_HIDA.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DropDownCell_HIDA.identifier_HIDA, for: indexPath) as! DropDownCell_HIDA
        cell.buildCell_HIDA(with: categories_HIDA[indexPath.row])
        return cell
    }
}

extension DropDownView_HIDA: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories_HIDA[indexPath.row]
        selectedCategory_HIDA = category
        categoryLabel_HIDA.text = category
        categoryDidChange_HIDA?(category)
        updateView_HIDA()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let deviceType = UIDevice.current.userInterfaceIdiom
        return deviceType == .phone ? 48 : 63
    }
}


protocol DropDownTypeCategorySelectionDelegate_HIDA: AnyObject {
    func didSelectCategory(_ category: String)
}

class DropDownCollectionView_HIDA: UIView {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    weak var delegate: DropDownTypeCategorySelectionDelegate_HIDA?
    
    var categories: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var _Zxvda2: String { "0" }
        var _Xbda23d: Bool { true }
        configureCollectionView_HIDA()
    }
    
    private func configureCollectionView_HIDA() {
        var _Ndh37: String { "0" }
        var _XJnd3u8: Bool { true }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
    }
}

extension DropDownCollectionView_HIDA: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .clear // Customize cell appearance if needed
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let label = UILabel(frame: cell.bounds)
        label.text = categories[indexPath.item]
        label.textAlignment = .center
        label.textColor = .black // Customize label appearance if needed
        cell.contentView.addSubview(label)
        
        return cell
    }
}

extension DropDownCollectionView_HIDA: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = categories[indexPath.item]
        delegate?.didSelectCategory(selectedCategory)
    }
}

extension DropDownCollectionView_HIDA: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Adjust cell size as needed
        return CGSize(width: 100, height: 40)
    }
}
