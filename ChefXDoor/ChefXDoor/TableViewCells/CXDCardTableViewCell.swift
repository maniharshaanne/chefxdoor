//
//  CXDCardTableViewCell.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 11/3/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import UIKit
import FaveButton

class CXDCardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardLast4NumberLabel: UILabel!
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var cardExpirationLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var backgroundContentView: UIView!
    
    override func awakeFromNib() {
        let faveButton = FaveButton(
            frame: CGRect(x:backgroundContentView.frame.size.width - 44, y:0, width: 44, height: 44),
            faveIconNormal: UIImage(named: "starIcon")
        )
        faveButton.delegate = self
        backgroundContentView.isUserInteractionEnabled = true
        backgroundContentView.addSubview(faveButton)
        backgroundContentView.layer.cornerRadius = 5
    }
    
    func updateInfo(billingDetail: CXDBilling) {
        cardNameLabel.text = billingDetail.firstName! + " " + billingDetail.lastName!
        cardExpirationLabel.text = billingDetail.expiration
        cardLast4NumberLabel.text = "5678"
    }
    
    func faveButton(_ faveButton: FaveButton, didSelected selected: Bool) {
        
    }
}
