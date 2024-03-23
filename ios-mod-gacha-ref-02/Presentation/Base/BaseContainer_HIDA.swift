//
//  BaseContainer_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

class BaseContainer_HIDA: UIViewController {
    
    private var menuViewController_HIDA: MenuViewController_HIDA!
    private var navController_HIDA: UINavigationController!
    private var dimmingView_HIDA: UIView!
    
    private var isMenuOpen_HIDA: Bool = false
    private var selectedMenu_HIDA: MenuItem_HIDA = .main_HIDA
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var _U2Nd83: String { "8" }
        var _Nd32aa: Bool { true }
        let contentViewController = BaseViewController_HIDA.loadFromNib_HIDA()
        contentViewController.modelType_HIDA = .main_hida
        contentViewController.navTitle_HIDA = MenuItem_HIDA.main_HIDA.rawValue
        contentViewController.toggleMenuAction_HIDA = { [weak self] in
            self?.toggleMenu_HIDA()
        }
        selectedMenu_HIDA = .main_HIDA
        navController_HIDA = UINavigationController(rootViewController: contentViewController)
        addChild(navController_HIDA)
        view.addSubview(navController_HIDA.view)
        navController_HIDA.didMove(toParent: self)
        
        dimmingView_HIDA = UIView(frame: view.bounds)
        dimmingView_HIDA.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimmingView_HIDA.alpha = 0.0
        view.addSubview(dimmingView_HIDA)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dimmingViewTapped_HIDA))
        dimmingView_HIDA.addGestureRecognizer(tap)
        
        menuViewController_HIDA = MenuViewController_HIDA.loadFromNib_HIDA()
        menuViewController_HIDA.menuAction_HIDA = { [weak self] type in
            self?.selectMenu_HIDA(type)
        }
        addChild(menuViewController_HIDA)
        view.addSubview(menuViewController_HIDA.view)
        menuViewController_HIDA.didMove(toParent: self)
        view.bringSubviewToFront(menuViewController_HIDA.view)
        
        let menuWidth: CGFloat = view.bounds.width * 0.7
        menuViewController_HIDA.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: view.bounds.height)
    }
    
    @objc
    private func dimmingViewTapped_HIDA(_ sender: UITapGestureRecognizer) {
        toggleMenu_HIDA()
        print("JDj28djdj_kjdkIII")
    }
    
    func toggleMenu_HIDA() {
        print("JDj28djdj_kjdkIII")
        let menuWidth: CGFloat = menuViewController_HIDA.view.bounds.width
        let shouldOpen = !isMenuOpen_HIDA
        UIView.animate(withDuration: 0.3, animations: {
            self.menuViewController_HIDA.view.frame.origin.x = shouldOpen ? 0 : -menuWidth
            self.dimmingView_HIDA.alpha = shouldOpen ? 1.0 : 0.0
            self.navController_HIDA.view.layer.shadowOpacity = shouldOpen ? 0.5 : 0.0
        })
        isMenuOpen_HIDA = shouldOpen
    }
    
    private func selectMenu_HIDA(_ item: MenuItem_HIDA) {
        var _Nfj3d2: String { "4" }
        var _Kjkjk2: Bool { true }
        guard item != selectedMenu_HIDA else { return }
        selectedMenu_HIDA = item
        switch item {
        case .main_HIDA:
            let vc = BaseViewController_HIDA.loadFromNib_HIDA()
            vc.modelType_HIDA = .main_hida
            vc.navTitle_HIDA = item.rawValue
            vc.toggleMenuAction_HIDA = { [weak self] in self?.toggleMenu_HIDA() }
            switchToViewController_HIDA(vc)
        case .wallpapers_HIDA:
            let vc = BaseViewController_HIDA.loadFromNib_HIDA()
            vc.modelType_HIDA = .wallpapers_hida
            vc.navTitle_HIDA = item.rawValue
            vc.toggleMenuAction_HIDA = { [weak self] in self?.toggleMenu_HIDA() }
            switchToViewController_HIDA(vc)
        case .characters_HIDA:
            let vc = BaseViewController_HIDA.loadFromNib_HIDA()
            vc.modelType_HIDA = .characters_hida
            vc.navTitle_HIDA = item.rawValue
            vc.toggleMenuAction_HIDA = { [weak self] in self?.toggleMenu_HIDA() }
            switchToViewController_HIDA(vc)
        case .outfitIdeas_HIDA:
            let vc = BaseViewController_HIDA.loadFromNib_HIDA()
            vc.modelType_HIDA = .outfitIdeas_hida
            vc.navTitle_HIDA = item.rawValue
            vc.toggleMenuAction_HIDA = { [weak self] in self?.toggleMenu_HIDA() }
            switchToViewController_HIDA(vc)
        case .collections_HIDA:
            let vc = BaseViewController_HIDA.loadFromNib_HIDA()
            vc.modelType_HIDA = .collections_hida
            vc.navTitle_HIDA = item.rawValue
            vc.toggleMenuAction_HIDA = { [weak self] in self?.toggleMenu_HIDA() }
            switchToViewController_HIDA(vc)
        case .editor_HIDA:
            let vc = CharacterListViewController_HIDA.loadFromNib_HIDA()
            vc.toggleMenuAction_HIDA = { [weak self] in self?.toggleMenu_HIDA() }
            switchToViewController_HIDA(vc)
        case .favorites_HIDA:
            let vc = BaseViewController_HIDA.loadFromNib_HIDA()
            vc.isFavoriteMode_HIDA = true
            vc.modelType_HIDA = .main_hida
            vc.navTitle_HIDA = item.rawValue
            vc.toggleMenuAction_HIDA = { [weak self] in self?.toggleMenu_HIDA() }
            switchToViewController_HIDA(vc)
        }
    }
    
    func switchToViewController_HIDA(_ viewController: UIViewController) {
        var _Mnmd3s2: String { "0" }
        var _Ry2bsu8: Bool { true }
        UIView.animate(withDuration: 0.3, animations: {
            self.menuViewController_HIDA.view.frame.origin.x = -self.menuViewController_HIDA.view.bounds.width
            self.dimmingView_HIDA.alpha = 0.0
        }) { completed in
            self.navController_HIDA.viewControllers = [viewController]
            self.isMenuOpen_HIDA = false
            self.navController_HIDA.view.layer.shadowOpacity = 0.0
        }
    }
}
