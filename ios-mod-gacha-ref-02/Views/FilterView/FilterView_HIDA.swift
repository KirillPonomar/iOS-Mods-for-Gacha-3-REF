//
//  FilterView_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

class FilterView_HIDA: UIView {
    
    @IBOutlet private weak var collectionView_HIDA: UICollectionView!
    @IBOutlet private weak var rightIndentConstraint_HIDA: NSLayoutConstraint!
    @IBOutlet private weak var leftIndentConstraint_HIDA: NSLayoutConstraint!
    @IBOutlet private weak var collectionViewHeight_HIDA: NSLayoutConstraint!
    
    var filters_HIDA: [Filter_HIDA] = []
    
    var activeFilter_HIDA: Filter_HIDA = .all_hida
    var filtersAction_HIDA: ((Filter_HIDA) -> Void)?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib_HIDA()
        configureLayout_HIDA()
        configureCollectionView_HIDA()
    }
    
    init() {
        super.init(frame: .zero)
        loadViewFromNib_HIDA()
        configureLayout_HIDA()
        configureCollectionView_HIDA()
    }
    
    private func configureLayout_HIDA() {
        let deviceType = UIDevice.current.userInterfaceIdiom
        rightIndentConstraint_HIDA.constant = deviceType == .phone ? 20 : 85
        leftIndentConstraint_HIDA.constant = deviceType == .phone ? 20 : 85
        collectionViewHeight_HIDA.constant = deviceType == .phone ? 32 : 44
    }
    
    func configureCollectionView_HIDA() {
        collectionView_HIDA.allowsMultipleSelection = false
        collectionView_HIDA.registerNib_HIDA(for: FilterCell_HIDA.self)
    }
}

extension FilterView_HIDA: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters_HIDA.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue_HIDA(id: FilterCell_HIDA.self, for: indexPath)
        let filter = filters_HIDA[indexPath.item]
        let filterText = filter.rawValue
        if activeFilter_HIDA == filter,
           !(collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false) {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
        }
        cell.configure_HIDA(with: filterText)
        cell.update_HIDA(with: activeFilter_HIDA == filter)
        return cell
    }
}

extension FilterView_HIDA: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let filter = filters_HIDA[indexPath.item].rawValue
        let deviceType = UIDevice.current.userInterfaceIdiom
        let fontSize: CGFloat = deviceType == .phone ? 18 : 28
        let font = UIFont(name: "BakbakOne-Regular", size: fontSize)!
        let width = UILabel.widthForLabel_HIDA(text: filter, font: font)
        let height: CGFloat = deviceType == .phone ? 32 : 44
        let indent: CGFloat = deviceType == .phone ? 24 : 56
        return CGSize(width: width + indent, height: height)
    }
}

extension FilterView_HIDA: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filter = filters_HIDA[indexPath.item]
        activeFilter_HIDA = filter
        filtersAction_HIDA?(activeFilter_HIDA)
    }
}
