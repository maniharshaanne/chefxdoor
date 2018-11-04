//
//  CXDAddressTableViewCell.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 11/3/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import UIKit

class CXDAddressTableViewCell: UITableViewCell {
    @IBOutlet weak var streetAddress1Label: UILabel!
    @IBOutlet weak var streetAddress2Label: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateZipLabel: UILabel!
    
    func updateInfo(address: CXDDeliveryAddress) {
     
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
}
