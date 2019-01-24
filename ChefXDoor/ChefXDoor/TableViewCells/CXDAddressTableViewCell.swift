//
//  CXDAddressTableViewCell.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 11/3/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import UIKit
import FaveButton

class CXDAddressTableViewCell: UITableViewCell, FaveButtonDelegate {
    @IBOutlet weak var streetAddress1Label: UILabel!
    @IBOutlet weak var streetAddress2Label: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateZipLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        let faveButton = FaveButton(
            frame: CGRect(x:mainView.frame.size.width - 44, y:mainView.frame.size.height/2 - 20 , width: 44, height: 44),
            faveIconNormal: UIImage(named: "starIcon")
        )
        faveButton.delegate = self
        faveButton.selectedColor = CXDAppearance.primaryColor()
        mainView.isUserInteractionEnabled = true
        mainView.addSubview(faveButton)
    }
    
    func updateInfo(address: CXDDeliveryAddress) {
     
        mainView.layer.borderColor = CXDAppearance.primaryColor().cgColor
        mainView.layer.borderWidth = 2
        
        streetAddress1Label.text = address.street
        streetAddress2Label.text = nil
        cityLabel.text = address.city
        
        if let state = address.state, let zipcode = address.zip?.stringValue
        {
            stateZipLabel.text = state + ", " + zipcode
        } else
        {
            stateZipLabel.text = nil
        }
    }
    
    func faveButton(_ faveButton: FaveButton, didSelected selected: Bool) {
        
    }
}
