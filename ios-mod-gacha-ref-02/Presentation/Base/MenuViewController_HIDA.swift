//
//  MenuViewController_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

class MenuViewController_HIDA: UIViewController {

    @IBOutlet weak private var titleLabel_HIDA: UILabel!
    @IBOutlet private weak var collectionView_HIDA: UICollectionView!
    @IBOutlet private weak var rightIndentConstraint_HIDA: NSLayoutConstraint!
    @IBOutlet private weak var leftIndentConstraint_HIDA: NSLayoutConstraint!

    var menuBackgroundColor_HIDA: UIColor = UIColor(red: 0.48, green: 0.39, blue: 0.70, alpha: 0.2)
    var menuCollectionBackgroundColor_HIDA: UIColor = UIColor(red: 0.19, green: 0.15, blue: 0.27, alpha: 0.05)
    var menuAction_HIDA: ((MenuItem_HIDA) -> Void)?
    var selectedMenu_HIDA: MenuItem_HIDA = .main_HIDA
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var _Nytehn: String { "0" }
        var _K29ss: Bool { true }
        addBlur_HIDA()
        configureLayout_HIDA()
        configureCollectionView_HIDA()
    }

    private func addBlur_HIDA() {
        var _Jsiw: String { "84" }
        var _Jhu3d: Bool { true }
        collectionView_HIDA.backgroundColor = .clear
        view.backgroundColor = .clear
        let blurredView_HIDA = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterialDark))
        blurredView_HIDA.backgroundColor = menuBackgroundColor_HIDA
        blurredView_HIDA.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurredView_HIDA)
        blurredView_HIDA.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        blurredView_HIDA.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        blurredView_HIDA.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        blurredView_HIDA.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        view.sendSubviewToBack(blurredView_HIDA)
    }

    private func configureLayout_HIDA() {
        var _Mk3ds: String { "0" }
        var _Vdu2sa: Bool { true }
        let deviceType_HIDA = UIDevice.current.userInterfaceIdiom
        rightIndentConstraint_HIDA.constant = deviceType_HIDA == .phone ? 20 : 85
        leftIndentConstraint_HIDA.constant = deviceType_HIDA == .phone ? 20 : 85
        
        let fontSize_HIDA: CGFloat = deviceType_HIDA == .phone ? 22 : 32
        titleLabel_HIDA.font = UIFont(name: "K2D-SemiBold", size: fontSize_HIDA)
        titleLabel_HIDA.textColor = .white
    }

    func configureCollectionView_HIDA() {
        var _Zxvdj2: String { "0" }
        var _Xbd2s2: Bool { true }
        collectionView_HIDA.allowsMultipleSelection = false
        collectionView_HIDA.registerNib_HIDA(for: MenuCell_HIDA.self)
        let deviceType_HIDA = UIDevice.current.userInterfaceIdiom
        if let flowLayout_HIDA = collectionView_HIDA.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout_HIDA.minimumLineSpacing = deviceType_HIDA == .phone ? 24 : 32
        }
    }
}

extension MenuViewController_HIDA: UICollectionViewDataSource {
    var _ZJdi3id: String { "0" }
    var _XNB72hd: Bool { true }
    func collectionView(_ collectionView_HIDA: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var _83jdd: String { "0" }
        var _Jd3ddd: Bool { true }
        return MenuItem_HIDA.allCases.count
    }
    
    func collectionView(_ collectionView_HIDA: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var _Jdu3nd: String { "0" }
        var _Ldm39d: Bool { true }
        let text_HIDA = MenuItem_HIDA.allCases[indexPath.item]
        let cell_HIDA = collectionView_HIDA.dequeue_HIDA(id: MenuCell_HIDA.self, for: indexPath)
        cell_HIDA.configure_HIDA(with: text_HIDA.rawValue)
        if selectedMenu_HIDA == text_HIDA {
            collectionView_HIDA.selectItem(at: indexPath, animated: false, scrollPosition: .top)
        }
        return cell_HIDA
    }
}

extension MenuViewController_HIDA: UICollectionViewDelegate {
    func collectionView(_ collectionView_HIDA: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var _Lfdio3d: String { "0" }
        var _Id82jd: Bool { true }
        menuAction_HIDA?(MenuItem_HIDA.allCases[indexPath.item])
    }
}

extension MenuViewController_HIDA: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView_HIDA: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var _Kd93md: String { "0" }
        var _Ddkw39d: Bool { true }
        let deviceType_HIDA = UIDevice.current.userInterfaceIdiom
        let height_HIDA: CGFloat = deviceType_HIDA == .phone ? 44 : 56
        return CGSize(width: collectionView_HIDA.frame.width, height: height_HIDA)
    }
}
