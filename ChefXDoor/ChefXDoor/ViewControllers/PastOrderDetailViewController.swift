//
//  PastOrderDetailViewController.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 10/13/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class PastOrderDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var orderItemsTableView:UITableView!
    @IBOutlet weak var stateCityZipLabel:UILabel!
    @IBOutlet weak var streetAddressLabel:UILabel!
    @IBOutlet weak var nameAddressLable:UILabel!
    @IBOutlet weak var tableViewHeightConstraint:NSLayoutConstraint!
    @IBOutlet weak var addressView:UIView!
    @IBOutlet weak var totalCostView:UIView!
    @IBOutlet weak var orderImageView: UIImageView!
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var orderCreatedTimeLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var transparentView: UIView!
    
    var orderItems:Array<CXDOrderItem>?
    var order:CXDOrder?
    var deliveryAddress:CXDDeliveryAddress?
    
    override func viewDidLoad() {
        
        orderItems = order?.orderItems
        deliveryAddress = order?.deliveryAddress
        
        //Address
        streetAddressLabel.text = deliveryAddress?.street
        let zipString = deliveryAddress?.zip?.stringValue
        let cityString = deliveryAddress?.city
        let stateString = deliveryAddress?.state
        let stateCityZipString = cityString! + ", " + stateString! + ", " + zipString!
        stateCityZipLabel.text = stateCityZipString
        
        //Tableviewcell
        orderItemsTableView.register(UINib.init(nibName: "CXDPastOrderItemTableViewCell", bundle: Bundle.init(for: CXDPastOrderItemTableViewCell.self)), forCellReuseIdentifier: "CXDPastOrderItemTableViewCell")
        
        //TableViewHeight
        orderItemsTableView.reloadData()
        orderItemsTableView.layoutIfNeeded()
        tableViewHeightConstraint.constant = orderItemsTableView.contentSize.height + 10
        
        addressView.layer.borderWidth = 2
        addressView.layer.borderColor = UIColor(red: 248/256, green: 101/256, blue: 64/256, alpha: 1).cgColor
        
        totalCostView.layer.borderWidth = 2
        totalCostView.layer.borderColor = UIColor(red: 248/256, green: 101/256, blue: 64/256, alpha: 1).cgColor
        
        orderNumberLabel.text = "Order #" + (order?.orderNumber?.stringValue)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let createdDate = dateFormatter.date(from: (order?.timeCreated!)!)
        
        if let _ = createdDate
        {
            dateFormatter.dateFormat = "MMM dd, yyyy, h:mm aa"
            let createdDateString = dateFormatter.string(from: createdDate!)
            orderCreatedTimeLabel.text = createdDateString
        }
        
        orderImageView.kf.cancelDownloadTask()
        
        if let imageUrl = order?.mainPhoto
        {
            let resource = ImageResource(downloadURL: URL.init(string: imageUrl)!)
            orderImageView.kf.setImage(with: resource)
        }
        
        transparentView.backgroundColor = UIColor(red: 98/256, green: 98/256, blue: 98/256, alpha: 0.5)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderItemsTableView.dequeueReusableCell(withIdentifier: "CXDPastOrderItemTableViewCell") as! CXDPastOrderItemTableViewCell
        cell.updateInfo(orderItem: orderItems![indexPath.row])
        cell.mainView.layer.borderColor = UIColor(red: 248/256, green: 101/256, blue: 64/256, alpha: 1).cgColor
        cell.mainView.layer.borderWidth = 2.0
        
        return cell
    }
}
