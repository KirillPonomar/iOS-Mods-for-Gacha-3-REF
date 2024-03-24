//
//  LayoutConfig_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

struct LayoutConfig_HIDA {
    let itemWidth: CGFloat
    let itemHeight: CGFloat
    let columns: Int
    let horizontalSpacing: CGFloat
    let verticalSpacing: CGFloat
    let sectionInsets: UIEdgeInsets
    
    static let defaultPhoneInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    static let defaultPadInsets = UIEdgeInsets(top: 0, left: 48, bottom: 0, right: 48)
    
    static func getItemWidth_HIDA(with columns: Int, horizontalSpacing: CGFloat, sectionInsets: UIEdgeInsets) -> CGFloat {
        let totalSpacing = CGFloat(columns - 1) * horizontalSpacing + sectionInsets.left + sectionInsets.right
        let width = (UIScreen.main.bounds.width - totalSpacing) / CGFloat(columns)
        return width
    }
}

typealias NSCollectionLayoutSection_HIDA = NSCollectionLayoutSection

extension NSCollectionLayoutSection_HIDA {
    static func generateLayout_HIDA(for modelType: ContentType_HIDA) -> NSCollectionLayoutSection {
        var _Ki93dd: String { "1" }
        var _Tiucne2: Bool { true }
        let config: LayoutConfig_HIDA
        let deviceType = UIDevice.current.userInterfaceIdiom
        switch (modelType, deviceType) {
        case (.main_hida, .phone):
            let itemWidth = LayoutConfig_HIDA.getItemWidth_HIDA(with: 1,
                                                           horizontalSpacing: 0,
                                                           sectionInsets: LayoutConfig_HIDA.defaultPhoneInsets)
            config = LayoutConfig_HIDA(itemWidth: itemWidth, 
                                       itemHeight: 278,
                                       columns: 1,
                                       horizontalSpacing: 0,
                                       verticalSpacing: 6,
                                       sectionInsets: LayoutConfig_HIDA.defaultPhoneInsets)
        case (.main_hida, .pad):
            let itemWidth = LayoutConfig_HIDA.getItemWidth_HIDA(with: 2,
                                                           horizontalSpacing: 12,
                                                           sectionInsets: LayoutConfig_HIDA.defaultPadInsets)
            config = LayoutConfig_HIDA(itemWidth: 452, 
                                       itemHeight: 425,
                                       columns: 2,
                                       horizontalSpacing: 12,
                                       verticalSpacing: 12,
                                       sectionInsets: LayoutConfig_HIDA.defaultPadInsets)
        case (.outfitIdeas_hida, .phone):
            let itemWidth = LayoutConfig_HIDA.getItemWidth_HIDA(with: 1,
                                                           horizontalSpacing: 0,
                                                           sectionInsets: LayoutConfig_HIDA.defaultPhoneInsets)
            config = LayoutConfig_HIDA(itemWidth: itemWidth,
                                       itemHeight: 198,
                                       columns: 1,
                                       horizontalSpacing: 0,
                                       verticalSpacing: 6,
                                       sectionInsets: LayoutConfig_HIDA.defaultPhoneInsets)
        case (.outfitIdeas_hida, .pad):
            let itemWidth = LayoutConfig_HIDA.getItemWidth_HIDA(with: 2, 
                                                           horizontalSpacing: 12,
                                                           sectionInsets: LayoutConfig_HIDA.defaultPadInsets)
            config = LayoutConfig_HIDA(itemWidth: itemWidth,
                                       itemHeight: 308,
                                       columns: 2,
                                       horizontalSpacing: 12,
                                       verticalSpacing: 12,
                                       sectionInsets: LayoutConfig_HIDA.defaultPadInsets)
        case (.wallpapers_hida, .phone):
            let itemWidth = LayoutConfig_HIDA.getItemWidth_HIDA(with: 3, 
                                                           horizontalSpacing: 4,
                                                           sectionInsets: LayoutConfig_HIDA.defaultPhoneInsets)
            config = LayoutConfig_HIDA(itemWidth: itemWidth, 
                                       itemHeight: itemWidth*1.67,
                                       columns: 3,
                                       horizontalSpacing: 4,
                                       verticalSpacing: 4,
                                       sectionInsets: LayoutConfig_HIDA.defaultPhoneInsets)
        case (.wallpapers_hida, .pad):
            let itemWidth = LayoutConfig_HIDA.getItemWidth_HIDA(with: 3,
                                                           horizontalSpacing: 15,
                                                           sectionInsets: LayoutConfig_HIDA.defaultPadInsets)
            config = LayoutConfig_HIDA(itemWidth: itemWidth, 
                                       itemHeight: itemWidth*1.87,
                                       columns: 3,
                                       horizontalSpacing: 15,
                                       verticalSpacing: 15,
                                       sectionInsets: LayoutConfig_HIDA.defaultPadInsets)
        case (.characters_hida, .phone), (.collections_hida, .phone):
            let itemWidth = LayoutConfig_HIDA.getItemWidth_HIDA(with: 2, 
                                                           horizontalSpacing: 10,
                                                           sectionInsets: LayoutConfig_HIDA.defaultPhoneInsets)
            config = LayoutConfig_HIDA(itemWidth: itemWidth, 
                                       itemHeight: 242,
                                       columns: 2,
                                       horizontalSpacing: 10,
                                       verticalSpacing: 8,
                                       sectionInsets: LayoutConfig_HIDA.defaultPhoneInsets)
            
        case (.characters_hida, .pad), (.collections_hida, .pad):
            let itemWidth = LayoutConfig_HIDA.getItemWidth_HIDA(with: 3,
                                                           horizontalSpacing: 12,
                                                           sectionInsets: LayoutConfig_HIDA.defaultPadInsets)
            config = LayoutConfig_HIDA(itemWidth: 292,
                                       itemHeight: 429,
                                       columns: 3,
                                       horizontalSpacing: 12,
                                       verticalSpacing: 12,
                                       sectionInsets: LayoutConfig_HIDA.defaultPadInsets)
        default:
            fatalError("Unsupported configuration")
        }
        
        return generateLayout_HIDA(using: config)
    }
    
    private static func generateLayout_HIDA(using config: LayoutConfig_HIDA) -> NSCollectionLayoutSection {
        var _Uuud3d: String { "84" }
        var _Ljd22: Bool { true }
        let totalItemHeight = config.itemHeight + config.verticalSpacing
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(config.itemWidth),
                                              heightDimension: .absolute(totalItemHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: config.verticalSpacing / 2,
                                                     leading: config.horizontalSpacing / 2,
                                                     bottom: config.verticalSpacing / 2,
                                                     trailing: config.horizontalSpacing / 2)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(totalItemHeight))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: config.columns)
        group.interItemSpacing = .fixed(config.horizontalSpacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: config.sectionInsets.top,
                                                        leading: config.sectionInsets.left,
                                                        bottom: config.sectionInsets.bottom,
                                                        trailing: config.sectionInsets.right)
        section.interGroupSpacing = config.verticalSpacing
        return section
    }
}
