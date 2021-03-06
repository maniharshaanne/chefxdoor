//
//  CXDItemsTableViewController.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 11/3/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import UIKit

class CXDItemsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var itemsTableView: UITableView!
    
    var billingItems: [CXDBilling]?
    var addressItems: [CXDDeliveryAddress]?
    var itemType: contentType?
    
    enum contentType {
        case addressType
        case cardType
    }
    
    override func viewDidLoad() {
        itemsTableView.register(UINib.init(nibName: "CXDCardTableViewCell", bundle: nil), forCellReuseIdentifier: "CXDCardTableViewCell")
        itemsTableView.register(UINib.init(nibName: "CXDAddressTableViewCell", bundle: nil), forCellReuseIdentifier: "CXDAddressTableViewCell")
        itemsTableView.rowHeight = UITableViewAutomaticDimension
        itemsTableView.estimatedRowHeight = 150
        
        switch self.itemType {
            case .addressType? :
                addButton.setTitle("Add New Address", for: .normal)
                break
            case .cardType?:
                addButton.setTitle("Add New Payment", for: .normal)
                break
            default:
                addButton.setTitle("Add New", for: .normal)
                break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch self.itemType {
        case .addressType? :
                return addressItems?.count ?? 0
        case .cardType?:
                return billingItems?.count ?? 0
        default:
                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.itemType {
        case .addressType? :
            let cell = itemsTableView.dequeueReusableCell(withIdentifier: "CXDAddressTableViewCell") as! CXDAddressTableViewCell
            cell.updateInfo(address: addressItems![indexPath.row])
            return cell
        case .cardType?:
            let cell = itemsTableView.dequeueReusableCell(withIdentifier: "CXDCardTableViewCell") as! CXDCardTableViewCell
            cell.updateInfo(billingDetail: billingItems![indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.init(for: AddNewPaymentViewController.self))

        switch itemType {
        case .addressType?:
            
            let addNewAddressViewController =  storyboard.instantiateViewController(withIdentifier: "CXDAddNewAddressViewController") as! CXDAddNewAddressViewController
            self.navigationController!.pushViewController(addNewAddressViewController, animated: true)
            break
        case .cardType?:
            let addNewPaymentViewController = storyboard.instantiateViewController(withIdentifier: "AddNewPaymentViewController") as! AddNewPaymentViewController
            self.navigationController!.pushViewController(addNewPaymentViewController, animated: true)
            break
        default:
            break
        }
    }
}
