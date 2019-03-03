//
//  CartItemTableViewCell.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 9/26/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import UIKit

class CartItemTableViewCell: UITableViewCell {
 
    @IBOutlet weak var mealNameLabel:UILabel!
    @IBOutlet weak var chefNameLabel:UILabel!
    @IBOutlet weak var mealPriceLabel:UILabel!
    @IBOutlet weak var mealQuantityLabel:UILabel!
    @IBOutlet weak var minusButton:UIButton!
    @IBOutlet weak var plusButton:UIButton!
    @IBOutlet weak var mealCountLabel:UILabel!
    @IBOutlet weak var deleteButton:UIButton!
    @IBOutlet weak var mainView:UIView!
    var deleteAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        deleteButton.layer.cornerRadius = deleteButton.frame.size.width/2
        self.mainView.layer.borderColor = CXDAppearance.primaryColor().cgColor
        self.mainView.layer.borderWidth = 2.0
    }
    
    public func updateInfo(cartItem: CXDCartItem)
    {
        mealNameLabel.text = cartItem.mealName
        chefNameLabel.text = "by " + cartItem.chefName!
        mealPriceLabel.text = "$" + (cartItem.price?.stringValue)!
        mealQuantityLabel.text = "Qty " + (cartItem.quantity?.stringValue)!
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        deleteAction!()
    }
    
    
}
