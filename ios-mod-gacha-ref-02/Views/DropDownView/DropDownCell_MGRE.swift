//
//  DropDownCell_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Andrii Bala on 11/13/23.
//

import UIKit

class DropDownCell_MGRE: UITableViewCell {
    
    @IBOutlet public weak var titleLabel_MGRE: UILabel!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setup_MGRE()
    }
    
    private func setup_MGRE() {
        selectionStyle = .none
        let deviceType = UIDevice.current.userInterfaceIdiom
        let fontSize: CGFloat = deviceType == .phone ? 18 : 28
        titleLabel_MGRE.font = UIFont(name: "BakbakOne-Regular", size: fontSize)!
    }
    
    public func buildCell_MGRE(with category: String, titleColor: UIColor = .white) {
        titleLabel_MGRE.text = category
        titleLabel_MGRE.textColor = titleColor
    }
}
