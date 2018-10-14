//
//  CXDPastOrderItemTableViewCell.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 10/13/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import UIKit

class CXDPastOrderItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dishCountLabel:UILabel!
    @IBOutlet weak var mealNameLabel:UILabel!
    @IBOutlet weak var chefNameLabel:UILabel!
    @IBOutlet weak var mealPriceLabel:UILabel!
    @IBOutlet weak var mealQuantityLabel:UILabel!
    @IBOutlet weak var mainView:UIView!
    @IBOutlet weak var ratingView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        ratingView.didFinishTouchingCosmos = { rating in
            self.ratingView.rating = rating
        }

    }
    
    public func updateInfo(orderItem: CXDOrderItem)
    {
        dishCountLabel.text = "Dish 0"
        mealNameLabel.text = orderItem.mealName
        chefNameLabel.text = "by " + orderItem.chefUsername!
        mealPriceLabel.text = "$" + (orderItem.mealPrice?.stringValue)!
        mealQuantityLabel.text = "Qty " + (orderItem.quantity?.stringValue)!
    }
}
