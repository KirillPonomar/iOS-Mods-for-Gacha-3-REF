//
//  DropDownCell_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

class DropDownCell_HIDA: UITableViewCell {
    
    @IBOutlet public weak var titleLabel_HIDA: UILabel!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setup_HIDA()
    }
    
    private func setup_HIDA() {
        selectionStyle = .none
        let deviceType = UIDevice.current.userInterfaceIdiom
        let fontSize: CGFloat = deviceType == .phone ? 18 : 28
        titleLabel_HIDA.font = UIFont(name: "BakbakOne-Regular", size: fontSize)!
    }
    
    public func buildCell_HIDA(with category: String, titleColor: UIColor = .white) {
        titleLabel_HIDA.text = category
        titleLabel_HIDA.textColor = titleColor
    }
}
