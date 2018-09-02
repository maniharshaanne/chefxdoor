//
//  SampleTableCell.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 7/28/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import UIKit

class SampleTableCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet private weak var selectedView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        selectedView.backgroundColor = selected ? UIColor.yellow : UIColor.clear
        titleLabel.textColor = selected ? UIColor.yellow : UIColor.white
    }
}
