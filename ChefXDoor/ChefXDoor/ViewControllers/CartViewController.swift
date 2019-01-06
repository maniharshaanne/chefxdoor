//
//  CartViewController.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 9/29/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import UIKit
import PKHUD

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
        
        //Navbar
        self.navigationItem.leftBarButtonItem = self.menuLeftBarButton()
        self.navigationItem.rightBarButtonItem = self.searchRightBarButton()
        self.navigationController?.navigationBar.barTintColor = UIColor.darkGray

        //Tableviewcell
        cartItemsTableView.register(UINib.init(nibName: "CartItemTableViewCell", bundle: Bundle.init(for: CartItemTableViewCell.self)), forCellReuseIdentifier: "CartItemTableViewCell")
        
        CXDApiServiceController.awsGetFromEndPoint(urlString: "/users/41/cart", queryParametersDict: nil, pathParametersDict: nil, classType: CXDCart.self).continueWith { (task) -> Any? in
            
            DispatchQueue.main.async {
                if task.error != nil {
                    let alertController = UIAlertController(title: "Error",
                                                            message: "Error occured while retreiving the cart",
                                                            preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertController.addAction(okAction)
                } else if let cart = task.result as? CXDCart {
                    self.cart = cart
                    
                    self.cartItems = self.cart?.cartItems
                    self.deliveryAddress = self.cart?.deliveryAddress
                    
                    //TableViewHeight
                    self.cartItemsTableView.reloadData()
                    self.cartItemsTableView.layoutIfNeeded()
                    self.tableViewHeightConstraint.constant = self.cartItemsTableView.contentSize.height + 10
                    
                    //Address
                    self.streetAddressLabel.text = self.deliveryAddress?.street
                    let zipString = self.self.deliveryAddress?.zip?.stringValue
                    let cityString = self.deliveryAddress?.city
                    let stateString = self.deliveryAddress?.state
                    let stateCityZipString = cityString! + ", " + stateString! + ", " + zipString!
                    self.stateCityZipLabel.text = stateCityZipString
                }
            }
        }
        
        //cartItems = cart?.cartItems
        //deliveryAddress = cart?.deliveryAddress
    
        addressView.layer.borderWidth = 2
        addressView.layer.borderColor = UIColor(red: 248/256, green: 101/256, blue: 64/256, alpha: 1).cgColor
        
        addNoteView.layer.borderWidth = 2
        addNoteView.layer.borderColor = UIColor(red: 248/256, green: 101/256, blue: 64/256, alpha: 1).cgColor
        
        totalCostView.layer.borderWidth = 2
        totalCostView.layer.borderColor = UIColor(red: 248/256, green: 101/256, blue: 64/256, alpha: 1).cgColor
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartItemsTableView.dequeueReusableCell(withIdentifier: "CartItemTableViewCell") as! CartItemTableViewCell
        cell.updateInfo(cartItem: cartItems![indexPath.row])
        cell.mainView.layer.borderColor = UIColor(red: 248/256, green: 101/256, blue: 64/256, alpha: 1).cgColor
        cell.mainView.layer.borderWidth = 2.0
        cell.deleteAction = {
            
            guard let selectedCartItem = self.cartItems?[indexPath.row] else {
                return
            }
            
            let userId = 41
            HUD.show(.progress, onView: self.navigationController?.view)
            if let carItemId = selectedCartItem.id?.intValue
            {
                let pathParameters = ["user_id": userId, "cart_item_id": carItemId]
                let deleteUrlString = "/users/\(userId)/cart/\(carItemId)"
                
                CXDApiServiceController.awsDeleteForEndPoint(urlString: deleteUrlString, queryParametersDict: nil, pathParametersDict: pathParameters).continueWith { (task) -> Any? in
                    DispatchQueue.main.async {
                        HUD.hide()
                        self.cartItems?.remove(at: indexPath.row)
                        self.cartItemsTableView.reloadData()
                    }
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


    }
    
    @IBAction func checkOutButtonPressed(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.init(for: PaymentViewController.self))
        let paymentViewController = storyboard.instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
        self.navigationController!.pushViewController(paymentViewController, animated: true)
    }
    
}
