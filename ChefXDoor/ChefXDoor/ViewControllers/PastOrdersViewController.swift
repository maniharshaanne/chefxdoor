//
//  PastOrdersViewController.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 10/9/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import UIKit
import PKHUD

class PastOrdersViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet public weak var pastOrderTableView:UITableView!
    public var pastOrders:Array<CXDOrder>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItems = customRightBarButtonItems()
        self.navigationItem.leftBarButtonItem = menuLeftBarButton()
        self.navigationController?.navigationBar.barTintColor = UIColor.darkGray
        self.pastOrderTableView.register(UINib.init(nibName: "CXDMealTableViewCell", bundle: Bundle.init(for: CXDMealTableViewCell.self)), forCellReuseIdentifier: "CXDMealTableViewCell")


    }
    
    override func viewDidAppear(_ animated: Bool) {
        HUD.show(.progress, onView: self.navigationController?.view)
        CXDApiServiceController.awsGetFromEndPoint(urlString: "/users/41/orders", queryParametersDict: nil, pathParametersDict: nil, classType: CXDOrder.self).continueWith { (task) -> Any? in
            
            DispatchQueue.main.async {
                HUD.hide()
                if let error = task.error {
                    print("Error: \(error)")
                } else if let result = task.result{
                    
                    if let previousOrders = result as? Array<CXDOrder>, previousOrders.count > 0
                    {
                        self.pastOrders = previousOrders
                        self.pastOrderTableView.reloadData()
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.pastOrders?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let orderCell:CXDMealTableViewCell = self.pastOrderTableView.dequeueReusableCell(withIdentifier: "CXDMealTableViewCell") as! CXDMealTableViewCell
        
        orderCell.updateInfo(order: pastOrders![indexPath.row])
        
        return orderCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let pastOrder:CXDOrder = pastOrders![indexPath.row]
        let urlString = "/users/41/orders/" + (pastOrder.id?.stringValue)!
        
        HUD.show(.progress, onView: self.navigationController?.view)
        CXDApiServiceController.awsGetFromEndPoint(urlString: urlString, queryParametersDict: nil, pathParametersDict: nil, classType: CXDOrder.self).continueWith { (task) -> Any? in
            
            DispatchQueue.main.async {
                HUD.hide()
                if let error = task.error {
                    print("Error: \(error)")
                } else if let result = task.result{
                    if let pastOrder = result as? CXDOrder
                    {
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let pastOrderDetailVC: PastOrderDetailViewController = mainStoryboard.instantiateViewController(withIdentifier: "PastOrderDetailViewController") as! PastOrderDetailViewController
                            pastOrderDetailVC.order = pastOrder
                            self.navigationController?.pushViewController(pastOrderDetailVC, animated: true)
                    }
                }
            }
        }
    }
}
