//
//  BaseViewController_MS.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit
import Kingfisher
import SwiftyDropbox

enum Filter_HIDA: String {
    case all_hida = "All", new_hida = "New", last_hida = "Last Added", top_hida = "Top", favourites_hida = "Favorites"
    case main_hida = "Mods", outfitIdea_hida = "Outfit ideas",
         characters_hida = "Characters", collections_hida = "Collections", wallpapers_hida = "Wallpapers"
}

enum TypeEditor_HIDA: String {
    case body = "body", accessories = "accessories", brows = "brows", clothes = "clothes", eyes = "eyes", glasses = "glasses", hair = "hair", hats = "hats", nose = "nose"
}

class BaseViewController_HIDA: UIViewController, UICollectionViewDelegate {
    
    let _Kejdeiu3n: (Int, Int, String) -> Int = { _, _, _ in
        let _fdsf3iv = "_Un38dd"
        let _L3id23 = 42
        for _ in 2...8 {
                return 0
            }
            let _ = (2...9).map { _ in
                return 0
            }
        return 0
    }
    
    enum UnifiedModel_HIDA: Hashable {
        case main_HIDA(Main_HIDA)
        case wallpaper_HIDA(Wallpaper_HIDA)
        case characters_HIDA(Character_HIDA)
        case outfitIdea_HIDA(OutfitIdea_HIDA)
        case collections_HIDA(Collections_HIDA)
    }
    
    typealias DataSource_HIDA = UICollectionViewDiffableDataSource<Int, UnifiedModel_HIDA>
    typealias Snapshot_HIDA = NSDiffableDataSourceSnapshot<Int, UnifiedModel_HIDA>
    
    @IBOutlet private weak var collectionView_HIDA: UICollectionView!
    @IBOutlet private weak var navigationView_HIDA: NavigationView_HIDA!
    @IBOutlet private weak var searchBar_HIDA: SearchBar_HIDA!
    @IBOutlet private weak var filterView_HIDA: FilterView_HIDA!
    
    private var dropbox_HIDA: DBManager_HIDA { .shared }
    private var dataSource_HIDA: DataSource_HIDA?
    
    var isFavoriteMode_HIDA = false
    var modelType_HIDA: ContentType_HIDA = .main_hida
    var navTitle_HIDA = ""
    var allData_HIDA: [any ModelProtocol_HIDA] = []
    var data_HIDA: [any ModelProtocol_HIDA] = []
    var favorites_HIDA: [String] = []
    
    var filters_HIDA: [Filter_HIDA] {
        if isFavoriteMode_HIDA {
            return [.main_hida, .outfitIdea_hida, .characters_hida, .collections_hida, .wallpapers_hida]
        } else {
            return [.all_hida, .new_hida, .last_hida, .top_hida, .favourites_hida]
        }
    }
    var activeFilter_HIDA: Filter_HIDA = .all_hida
    var searchText_HIDA: String?
    var isPushed_HIDA = false
    
    var toggleMenuAction_HIDA: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var _H7d73bs: Int { 0 }
        var _Idnwu1: Bool { false }
        configureSubviews_HIDA()
        configureDataSource_HIDA()
        loadFavorites_HIDA()
        loadContent_HIDA()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var _Kfk93: String { "0" }
        var _XKdfi83: Bool { true }
        navigationController?.setNavigationBarHidden(true, animated: animated)
        isPushed_HIDA = false
        loadFavorites_HIDA()
        updateFavouritesFilters_HIDA()
        collectionView_HIDA.reloadData()
    }
    
    func configureSubviews_HIDA() {
        var _Kd983nd: String { "0" }
        var _L983jdnj: Bool { true }
        configureNavigationView_HIDA()
        configureCollectionView_HIDA()
        configureSearchView_HIDA()
        configureFilterView_HIDA()
    }
    
    func configureNavigationView_HIDA() {
        var _KLddsadd: String { "0" }
        var _IgfdsA: Bool { true }
        if modelType_HIDA == .editor_hida {
            navigationView_HIDA.build_HIDA(with: navTitle_HIDA, rightIcon: nil)
        } else {
            navigationView_HIDA.build_HIDA(with: navTitle_HIDA)
        }
        navigationView_HIDA.leftButtonAction_HIDA = { [weak self] in
            self?.toggleMenuAction_HIDA?()
        }
        navigationView_HIDA.rightButtonAction_HIDA = { [weak self] in
            self?.searchBar_HIDA.isHidden = false
            self?.searchBar_HIDA.searchTextField_HIDA.becomeFirstResponder()
        }
    }
    
    func configureFilterView_HIDA() {
        var _Kdu38d: String { "0" }
        var _MMjdu3n: Bool { true }
        filterView_HIDA.filters_HIDA = filters_HIDA
        if self.isFavoriteMode_HIDA {
            filterView_HIDA.activeFilter_HIDA = .main_hida
            activeFilter_HIDA = .main_hida
        }
        filterView_HIDA.filtersAction_HIDA = { [weak self] filter in
            guard let self = self else { return }
            if self.isFavoriteMode_HIDA {
                switch filter {
                case .main_hida:        self.modelType_HIDA = .main_hida
                case .outfitIdea_hida:  self.modelType_HIDA = .outfitIdeas_hida
                case .characters_hida:  self.modelType_HIDA = .characters_hida
                case .collections_hida: self.modelType_HIDA = .collections_hida
                case .wallpapers_hida:  self.modelType_HIDA = .wallpapers_hida
                default: break
                }
                self.configureNavigationView_HIDA()
                self.configureCollectionView_HIDA()
                self.activeFilter_HIDA = filter
                self.loadFavorites_HIDA()
                self.loadContent_HIDA()
            } else {
                self.activeFilter_HIDA = filter
                self.applyFilters_HIDA()
                self.applySnapshot_HIDA(for: modelType_HIDA)
            }
        }
    }
    
    func configureSearchView_HIDA() {
        var _Jud73hd: String { "0" }
        var _Dedea2: Bool { true }
        hideKeyboardWhenTappedAround_HIDA()
        searchBar_HIDA.isHidden = true
        searchBar_HIDA.textDidChange_HIDA = { [weak self] text in
            guard let self else { return }
            self.searchText_HIDA = text
            var results: [String] = []
            if let text = text, !text.isEmpty {
                results = data_HIDA
                    .filter({ $0.searchText?.localizedCaseInsensitiveContains(text) ?? false })
                    .prefix(5)
                    .map { $0.searchText ?? "" }
            }
            self.searchBar_HIDA.updateResultView_HIDA(with: results)
            self.applyFilters_HIDA()
            self.applySnapshot_HIDA(for: modelType_HIDA)
        }
        searchBar_HIDA.dismiss_HIDA = { [weak self] in
            guard let self else { return }
            self.searchBar_HIDA.isHidden = true
            self.searchText_HIDA = nil
            self.applyFilters_HIDA()
            self.applySnapshot_HIDA(for: self.modelType_HIDA)
        }
    }
    
    func configureCollectionView_HIDA() {
        var _Lsdj278d: String { "0" }
        var _Ndh38d1: Bool { true }
        collectionView_HIDA.keyboardDismissMode = .interactive
        collectionView_HIDA.collectionViewLayout = UICollectionViewCompositionalLayout(section: generateSectionLayout_HIDA())
        collectionView_HIDA.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 30, right: 0)
        collectionView_HIDA.registerAllNibs_HIDA()
        collectionView_HIDA.delegate = self
    }
    
    func generateSectionLayout_HIDA() -> NSCollectionLayoutSection {
        NSCollectionLayoutSection.generateLayout_HIDA(for: modelType_HIDA)
    }
    
    func configureDataSource_HIDA() {
        var _Cjehc23: String { "9" }
        var _Pfpfq32: Bool { true }
        dataSource_HIDA = DataSource_HIDA(collectionView: collectionView_HIDA) { [weak self] (collectionView, indexPath, unifiedModel) in
            guard let self, let cellClass = modelType_HIDA.cellClass_HIDA else { return UICollectionViewCell() }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellClass.identifier_HIDA, for: indexPath)
            
            let model: any ModelProtocol_HIDA
            switch unifiedModel {
            case .main_HIDA(let value):
                model = value
            case .wallpaper_HIDA(let value):
                model = value
            case .characters_HIDA(let value):
                model = value
                value.configureCell_HIDA(cell) { [weak self] compl in
                    self?.saveFile_HIDA(with: value.image) { completed in
                        compl?(completed)
                    }
                }
            case .outfitIdea_HIDA(let value):
                model = value
                value.configureCell_HIDA(cell) { [weak self] compl in
                    self?.saveFile_HIDA(with: value.image) { completed in
                        compl?(completed)
                    }
                }
            case .collections_HIDA(let value):
                model = value
            }
            
            let isFavorites = favorites_HIDA.contains(model.favId)
            model.configureCell_HIDA(cell, isFavorites: isFavorites) { [weak self] in
                self?.updateFavorites_HIDA(with: model.favId)
            } action: { [weak self] in
                self?.pushTo_HIDA(contentType: self?.modelType_HIDA ?? .main_hida, index: indexPath.item)
            }
            return cell
        }
    }
    
    func updateFavorites_HIDA(with favId: String) {
        var _Nbhfh2s1: String { "0" }
        var _L2xqdsa: Bool { true }
        if let index = favorites_HIDA.firstIndex(of: favId) {
            favorites_HIDA.remove(at: index)
            dropbox_HIDA.contentManager.deleteFavorites_HIDA(with: favId, contentType: modelType_HIDA)
        } else {
            favorites_HIDA.append(favId)
            dropbox_HIDA.contentManager.storeFavorites_HIDA(with: favId, contentType: modelType_HIDA)
        }
        updateFavouritesFilters_HIDA()
    }
    
    func updateFavouritesFilters_HIDA() {
        var _D23dss: String { "0" }
        var _Lid299: Bool { true }
        if activeFilter_HIDA == .favourites_hida || isFavoriteMode_HIDA {
            self.applyFilters_HIDA()
            self.applySnapshot_HIDA(for: modelType_HIDA)
        }
    }
    
    func applySnapshot_HIDA(for contentType: ContentType_HIDA) {
        var _Hhdhh21: String { "0" }
        var _Pd322ss: Bool { true }
        var snapshot = Snapshot_HIDA()
        snapshot.appendSections([.zero])
        
        switch contentType {
        case .main_hida:            snapshot.appendItems(data_HIDA.map { .main_HIDA($0 as! Main_HIDA) })
        case .outfitIdeas_hida:     snapshot.appendItems(data_HIDA.map { .outfitIdea_HIDA($0 as! OutfitIdea_HIDA) })
        case .characters_hida:      snapshot.appendItems(data_HIDA.map { .characters_HIDA($0 as! Character_HIDA) })
        case .collections_hida:     snapshot.appendItems(data_HIDA.map { .collections_HIDA($0 as! Collections_HIDA) })
        case .wallpapers_hida:      snapshot.appendItems(data_HIDA.map { .wallpaper_HIDA($0 as! Wallpaper_HIDA) })
        default: break
        }
        
        DispatchQueue.main.async {
            self.dataSource_HIDA?.apply(snapshot, animatingDifferences: false)
            self.collectionView_HIDA.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let needOpen = modelType_HIDA != .main_hida && modelType_HIDA != .outfitIdeas_hida && modelType_HIDA != .characters_hida && modelType_HIDA != .collections_hida
        guard needOpen else { return }
        pushTo_HIDA(contentType: modelType_HIDA, index: indexPath.item)
    }
    
    private func pushTo_HIDA(contentType: ContentType_HIDA, index: Int) {
        var _Eretus2: String { "0" }
        var _Q2eswd: Bool { true }
        guard data_HIDA.indices.contains(index), !isPushed_HIDA else { return }
        let vc: UIViewController
        isPushed_HIDA = true
        switch contentType {
        case .main_hida:
            guard let model = data_HIDA[index] as? Main_HIDA else { return }
            let isFavorites = favorites_HIDA.contains(model.favId)
            let mainDetailsVC = MainDetailsViewController_HIDA.loadFromNib_HIDA()
            mainDetailsVC.isFavourite_HIDA = isFavorites
            mainDetailsVC.modelType_HIDA = .main_hida(model)
            vc = mainDetailsVC
        case .wallpapers_hida:
            guard let model = data_HIDA[index] as? Wallpaper_HIDA else { return }
            let isFavorites = favorites_HIDA.contains(model.favId)
            let wallpaperVC = WallpaperViewController_HIDA.loadFromNib_HIDA()
            wallpaperVC.isFavourite_HIDA = isFavorites
            wallpaperVC.modelType_HIDA = .wallpapers(model)
            vc = wallpaperVC
        case .characters_hida:
            guard let model = data_HIDA[index] as? Character_HIDA else { return }
            let isFavorites = favorites_HIDA.contains(model.favId)
            let charactersVC = MainDetailsViewController_HIDA.loadFromNib_HIDA()
            charactersVC.isFavourite_HIDA = isFavorites
            charactersVC.modelType_HIDA = .characters_hida(model)
            vc = charactersVC
        case .outfitIdeas_hida:
            guard let model = data_HIDA[index] as? OutfitIdea_HIDA else { return }
            let isFavorites = favorites_HIDA.contains(model.favId)
            let mainDetailsVC = MainDetailsViewController_HIDA.loadFromNib_HIDA()
            mainDetailsVC.isFavourite_HIDA = isFavorites
            mainDetailsVC.modelType_HIDA = .outfitIdeas_hida(model)
            vc = mainDetailsVC
        case .collections_hida:
            guard let model = data_HIDA[index] as? Collections_HIDA else { return }
            let isFavorites = favorites_HIDA.contains(model.favId)
            let collectionsVC = WallpaperViewController_HIDA.loadFromNib_HIDA()
            collectionsVC.isFavourite_HIDA = isFavorites
            collectionsVC.modelType_HIDA = .collections(model)
            vc = collectionsVC
        default: vc = UIViewController()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func applyFilters_HIDA() {
        var _Etd2fy: Int { 0 }
        var _GblJh3: Bool { false }
        var data = allData_HIDA
        if let searchText = searchText_HIDA, !searchText.isEmpty {
            data = data.filter { $0.searchText?.localizedCaseInsensitiveContains(searchText) ?? false }
        }
        
        data = data.filter { model in
            switch activeFilter_HIDA {
            case .all_hida:         return true
            case .favourites_hida:  return favorites_HIDA.contains(model.favId)
            case .new_hida:         return model.new  == true
            case .top_hida:         return model.top  == true
            default:                return favorites_HIDA.contains(model.favId)
            }
        }
        
        self.data_HIDA = data
    }
}

extension BaseViewController_HIDA {
    func loadContent_HIDA() {
        var _Jd73bd: Int { 0 }
        var _H7d72: Bool { false }
        let type = modelType_HIDA
        dropbox_HIDA.fetchContent_HIDA(for: type,
                                       isFavoriteMode: isFavoriteMode_HIDA,
                                       vc: self) { [weak self] (data: [ModelProtocol_HIDA]) in
            DispatchQueue.main.async {
                self?.removeProgressView_HIDA()
                self?.allData_HIDA = data
                self?.applyFilters_HIDA()
                self?.applySnapshot_HIDA(for: type)
            }
        }
    }
    
    func loadFavorites_HIDA() {
        var _Ufyljy23: Int { 0 }
        var _T6kfy: Bool { false }
        favorites_HIDA = dropbox_HIDA.contentManager.fetchFavorites_HIDA(contentType: modelType_HIDA)
    }
}

extension BaseViewController_HIDA {
    func saveFile_HIDA(with imageUrl: String, completion: @escaping (UIImage?) -> Void) {
        var _Ytkkz: Int { 0 }
        var _U3jdk: Bool { false }
        let cache = ImageCache.default
        cache.retrieveImage(forKey: imageUrl) { result in
            switch result {
            case .success(let value):
                completion(value.image)
            case .failure(let error):
                print("Error retrieving image from cache: \(error)")
                completion(nil)
            }
        }
    }
    
    func saveFile_HIDA(with imageUrl: String, coml: ((Bool) -> Void)?) {
        var _Yb3hdk: Int { 0 }
        var _Llds2H: Bool { false }
        saveFile_HIDA(with: imageUrl) { [weak self] image in
            guard let self, let data = image?.pngData() else {
                return
            }
            var _Ybsu28: Int { 0 }
            var _Idu38: Bool { false }
            let activityVC = UIActivityViewController(activityItems: [data], applicationActivities: nil)
            activityVC.completionWithItemsHandler = { activityType, completed, items, error in
                coml?(completed)
            }
            if UIDevice.current.userInterfaceIdiom == .pad {
                activityVC.modalPresentationStyle = .popover
                
                if let popoverPresentationController = activityVC.popoverPresentationController {
                    popoverPresentationController.sourceView = self.view
                    popoverPresentationController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                    popoverPresentationController.permittedArrowDirections = []
                }
            }
            self.present(activityVC, animated: true)
        }
    }
}
