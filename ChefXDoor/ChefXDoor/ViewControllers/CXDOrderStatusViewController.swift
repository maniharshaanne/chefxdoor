//
//  CXDOrderStatusViewController.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 12/9/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import UIKit

class CXDOrderStatusViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var nowCookingRoundView: UIView!
    @IBOutlet weak var readyForPickupView: UIView!
    @IBOutlet weak var deliveryOnTheWayView: UIView!
    @IBOutlet weak var foodDelivered: UIView!
    
    @IBOutlet weak var orderItemsTableView: UITableView!
    @IBOutlet weak var orderItemsTableViewHeightConstraint: NSLayoutConstraint!
    public var cartItems: [CXDCartItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.orderItemsTableView.reloadData()
        self.orderItemsTableView.layoutIfNeeded()
        self.orderItemsTableViewHeightConstraint.constant = self.orderItemsTableView.contentSize.height + 10
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}
