//
//  MenuViewController_MGRE.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

class MenuViewController_MGRE: UIViewController {

    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var rightIndentConstraint: NSLayoutConstraint!
    @IBOutlet private weak var leftIndentConstraint: NSLayoutConstraint!

    var menuBackgroundColor: UIColor = UIColor(red: 0.48, green: 0.39, blue: 0.70, alpha: 0.2)
    var menuCollectionBackgroundColor: UIColor = UIColor(red: 0.19, green: 0.15, blue: 0.27, alpha: 0.05)
    var menuAction_MGRE: ((MenuItem_MGRE) -> Void)?
    var selectedMenu_MGRE: MenuItem_MGRE = .main_MGRE
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addBlur()
        configureLayout_MGRE()
        configureCollectionView_MGRE()
    }

    private func addBlur() {
        collectionView.backgroundColor = .clear
        view.backgroundColor = .clear
        let blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterialDark))
        blurredView.backgroundColor = menuBackgroundColor
        blurredView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurredView)
        blurredView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        blurredView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        blurredView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        blurredView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        view.sendSubviewToBack(blurredView)
    }

    private func configureLayout_MGRE() {
        let deviceType = UIDevice.current.userInterfaceIdiom
        rightIndentConstraint.constant = deviceType == .phone ? 20 : 85
        leftIndentConstraint.constant = deviceType == .phone ? 20 : 85
        
        let fontSize: CGFloat = deviceType == .phone ? 22 : 32
        titleLabel.font = UIFont(name: "BakbakOne-Regular", size: fontSize)!
        titleLabel.textColor = .white
    }

    func configureCollectionView_MGRE() {
        collectionView.allowsMultipleSelection = false
        collectionView.registerNib_MGRE(for: MenuCell_MGRE.self)
        let deviceType = UIDevice.current.userInterfaceIdiom
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumLineSpacing = deviceType == .phone ? 24 : 32
        }
    }
}

extension MenuViewController_MGRE: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MenuItem_MGRE.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let text = MenuItem_MGRE.allCases[indexPath.item]
        let cell = collectionView.dequeue_MGRE(id: MenuCell_MGRE.self, for: indexPath)
        cell.configure_MGRE(with: text.rawValue)
        if selectedMenu_MGRE == text {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
        }
        return cell
    }
}

extension MenuViewController_MGRE: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        menuAction_MGRE?(MenuItem_MGRE.allCases[indexPath.item])
    }
}

extension MenuViewController_MGRE: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let deviceType = UIDevice.current.userInterfaceIdiom
        let height: CGFloat = deviceType == .phone ? 44 : 56
        return CGSize(width: collectionView.frame.width, height: height)
    }
}
