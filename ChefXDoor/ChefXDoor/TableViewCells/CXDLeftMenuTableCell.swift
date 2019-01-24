//
//  CXDLeftMenuTableCell.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 7/28/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import UIKit

class CXDLeftMenuTableCell: UITableViewCell {
    
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet private weak var menuItemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func updateInfo(menuItem : CXDAppMenuItem)
    {
        menuImageView.image = UIImage(named: menuItem.imageName!)
        menuImageView.image = menuImageView.image!.withRenderingMode(.alwaysTemplate)
        menuImageView.tintColor = CXDAppearance.primaryColor()
        menuItemLabel.text = menuItem.title
    }
}
