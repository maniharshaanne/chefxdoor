//
//  CartViewController.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 9/29/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import UIKit

class CartViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var cartItems:Array<CXDCartItem>?
    var cart:CXDCart?
    var deliveryAddress:CXDDeliveryAddress?
    
    @IBOutlet weak var totalLabel:UILabel!
    @IBOutlet weak var deliveryEstimateLabel:UILabel!
    @IBOutlet weak var checkOutButton:UIButton!
    @IBOutlet weak var cartItemsTableView:UITableView!
    @IBOutlet weak var editAddressButton:UIButton!
    @IBOutlet weak var stateCityZipLabel:UILabel!
    @IBOutlet weak var streetAddressLabel:UILabel!
    @IBOutlet weak var nameAddressLable:UILabel!
    @IBOutlet weak var tableViewHeightConstraint:NSLayoutConstraint!
    @IBOutlet weak var addressView:UIView!
    @IBOutlet weak var addNoteView:UIView!
    @IBOutlet weak var totalCostView:UIView!

    override func viewDidLoad() {
        cartItems = cart?.cartItems
        deliveryAddress = cart?.deliveryAddress
        
        //Address
        streetAddressLabel.text = deliveryAddress?.street
        let zipString = deliveryAddress?.zip?.stringValue
        let cityString = deliveryAddress?.city
        let stateString = deliveryAddress?.state
        let stateCityZipString = cityString! + ", " + stateString! + ", " + zipString!
        stateCityZipLabel.text = stateCityZipString
        
        //Tableviewcell
        cartItemsTableView.register(UINib.init(nibName: "CartItemTableViewCell", bundle: Bundle.init(for: CartItemTableViewCell.self)), forCellReuseIdentifier: "CartItemTableViewCell")
        
        //TableViewHeight
        cartItemsTableView.reloadData()
        cartItemsTableView.layoutIfNeeded()
        tableViewHeightConstraint.constant = cartItemsTableView.contentSize.height
        
        addressView.layer.borderWidth = 2
        addressView.layer.borderColor = UIColor(red: 248/256, green: 101/256, blue: 64/256, alpha: 1).cgColor
        
        addNoteView.layer.borderWidth = 2
        addNoteView.layer.borderColor = UIColor(red: 248/256, green: 101/256, blue: 64/256, alpha: 1).cgColor
        
        totalCostView.layer.borderWidth = 2
        totalCostView.layer.borderColor = UIColor(red: 248/256, green: 101/256, blue: 64/256, alpha: 1).cgColor
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ((cartItems?.count)! - 1) 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartItemsTableView.dequeueReusableCell(withIdentifier: "CartItemTableViewCell") as! CartItemTableViewCell
        cell.updateInfo(cartItem: cartItems![indexPath.row])
        cell.mainView.layer.borderColor = UIColor(red: 248/256, green: 101/256, blue: 64/256, alpha: 1).cgColor
        cell.mainView.layer.borderWidth = 2.0
        //cell.backgroundColor = UIColor(red: 91/256, green: 91/256, blue: 91/256, alpha: 1)
        
        return cell
    }
    
    @IBAction func checkOutButtonPressed(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.init(for: PaymentViewController.self))
        let paymentViewController = storyboard.instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
        self.navigationController!.pushViewController(paymentViewController, animated: true)
    }
    
}
