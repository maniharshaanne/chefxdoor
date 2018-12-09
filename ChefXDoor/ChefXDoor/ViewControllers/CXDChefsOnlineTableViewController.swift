//
//  CXDChefsOnlineTableViewController.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 10/14/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import UIKit
import AWSCognito

class CXDChefsOnlineTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var chefsCookingTableVIew:UITableView!
    var onlineChefs:Array<CXDChef>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chefsCookingTableVIew.register(UINib.init(nibName: "CXDChefTableViewCell", bundle: Bundle(for: CXDChefTableViewCell.self)), forCellReuseIdentifier: "CXDChefTableViewCell")
        chefsCookingTableVIew.rowHeight = UITableViewAutomaticDimension
        chefsCookingTableVIew.estimatedRowHeight = 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return onlineChefs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CXDChefTableViewCell = chefsCookingTableVIew.dequeueReusableCell(withIdentifier: "CXDChefTableViewCell") as! CXDChefTableViewCell
        cell.updateInfo(chefInfo: onlineChefs![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedChef = onlineChefs![indexPath.row]
        let chefId = selectedChef.id?.stringValue
        let urlString = "/users/" + chefId!

        CXDApiServiceController.awsGetFromEndPoint(urlString: urlString, queryParametersDict: ["lat" : 38.994373, "long" : -77.029778, "type": "chef"], pathParametersDict: nil, classType: CXDChef.self).continueWith { (task) -> Any? in
            
            DispatchQueue.main.async {
                if let error = task.error {
                    print("Error: \(error)")
                } else if let result = task.result{
                    let res = result as! CXDChef
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let chefDetailViewController = storyboard.instantiateViewController(withIdentifier: "ChefDetailViewController") as! ChefDetailViewController
                    res.reviewCount = selectedChef.reviewCount
                    res.categories = selectedChef.categories
                    chefDetailViewController.chef = res
                    self.navigationController?.pushViewController(chefDetailViewController, animated: true)
                }
            }
        }
    }
    
}
