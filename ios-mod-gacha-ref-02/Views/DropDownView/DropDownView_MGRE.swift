//
//  DropDownView_MGRE.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

class DropDownView_MGRE: UIView {
    
    @IBOutlet private weak var categoryLabel_MGRE: UILabel!
    @IBOutlet private weak var imageView_MGRE: UIImageView!
    @IBOutlet private weak var tableView_MGRE: UITableView!
    @IBOutlet private weak var categoryLabelHeight_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var tableViewHeight_MGRE: NSLayoutConstraint!
    
    var isOpen_MGRE: Bool = false
    var categories_MGRE: [String] = []
    var selectedCategory_MGRE: String = ""
    var categoryDidChange_MGRE: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib_MGRE()
        configureLayout_MGRE()
        configureTableView_MGRE()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadViewFromNib_MGRE()
        configureLayout_MGRE()
        configureTableView_MGRE()
    }
    
    func configureTableView_MGRE() {
        tableView_MGRE.allowsMultipleSelection = false
        tableView_MGRE.registerNib_MGRE(for: DropDownCell_MGRE.self)
    }
    
    private func configureLayout_MGRE() {
        let deviceType = UIDevice.current.userInterfaceIdiom
        let fontSize: CGFloat = deviceType == .phone ? 18 : 28
        categoryLabel_MGRE.font = UIFont(name: "BakbakOne-Regular", size: fontSize)!
        categoryLabelHeight_MGRE.constant = deviceType == .phone ? 48 : 63
        tableView_MGRE.isHidden = !isOpen_MGRE
        imageView_MGRE.image = isOpen_MGRE ? UIImage(.chevronTopIcon) : UIImage(.chevronBottomIcon)
    }
    
    func closeView_MGRE() {
        isOpen_MGRE = false
        tableView_MGRE.isHidden = !isOpen_MGRE
        imageView_MGRE.image = isOpen_MGRE ? UIImage(.chevronTopIcon) : UIImage(.chevronBottomIcon)
    }
    
    func setupDropDownView_MGRE(with categories: [String], selectedCategory: String) {
        self.categories_MGRE = categories
        self.selectedCategory_MGRE = selectedCategory
        
        let deviceType = UIDevice.current.userInterfaceIdiom
        tableViewHeight_MGRE.constant = deviceType == .phone ? CGFloat(48 * categories.count) : CGFloat(63 * categories.count)
        categoryLabel_MGRE.text = selectedCategory
        tableView_MGRE.reloadData()
    }
    
    @IBAction func openButtonDidTap_MGRE(_ sender: UIButton) {
        updateView_MGRE()
    }
    
    private func updateView_MGRE() {
        isOpen_MGRE.toggle()
        tableView_MGRE.isHidden = !isOpen_MGRE
        imageView_MGRE.image = isOpen_MGRE ? UIImage(.chevronTopIcon) : UIImage(.chevronBottomIcon)
    }
}

extension DropDownView_MGRE: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories_MGRE.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DropDownCell_MGRE.identifier_MGRE, for: indexPath) as! DropDownCell_MGRE
        cell.buildCell_MGRE(with: categories_MGRE[indexPath.row])
        return cell
    }
}

extension DropDownView_MGRE: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories_MGRE[indexPath.row]
        selectedCategory_MGRE = category
        categoryLabel_MGRE.text = category
        categoryDidChange_MGRE?(category)
        updateView_MGRE()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let deviceType = UIDevice.current.userInterfaceIdiom
        return deviceType == .phone ? 48 : 63
    }
}


protocol DropDownCategorySelectionDelegate: AnyObject {
    func didSelectCategory(_ category: String)
}

class DropDownCollectionView: UIView {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    weak var delegate: DropDownCategorySelectionDelegate?
    
    var categories: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
    }
}

extension DropDownCollectionView: UICollectionViewDataSource {
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

extension DropDownCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = categories[indexPath.item]
        delegate?.didSelectCategory(selectedCategory)
    }
}

extension DropDownCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Adjust cell size as needed
        return CGSize(width: 100, height: 40)
    }
}
