//
//  UserDetailTableViewController.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 6/14/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import AWSCognito
import AWSCognitoIdentityProvider

class UserDetailTableViewController : UITableViewController {
    
    var response: AWSCognitoIdentityUserGetDetailsResponse?
    var user: AWSCognitoIdentityUser?
    var pool: AWSCognitoIdentityUserPool?
    
    convenience init() {
        self.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.pool = appDelegate.cxdIdentityUserPool
        self.pool?.delegate = appDelegate
        if (self.user == nil) {
            self.user = self.pool?.currentUser()
        }
        self.refresh()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.refresh()
        super.viewWillDisappear(animated)
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(false, animated: true)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let response = self.response  {
            return response.userAttributes!.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "attribute", for: indexPath)
        let userAttribute = self.response?.userAttributes![indexPath.row]
        cell.textLabel!.text = userAttribute?.name
        cell.detailTextLabel!.text = userAttribute?.value
        return cell
    }
  
    // MARK: - IBActions

    @IBAction func testApi(_ sender: Any) {
        self.getMeals(token: "")
 
    }
    
    @IBAction func signOut(_ sender: AnyObject) {
                
        self.user?.signOut()
        self.title = nil
        self.response = nil
        self.tableView.reloadData()
        self.refresh()
    }
    
    func getMeals(token:String)
    {
        let client =  CXDDEVAPIClient.client(forKey: "USEast1CXDDEVAPIClient")
        client.apiKey = "zbT9ToJQNC9GdoHvJjPPM4eAB6axiHBB7iAdXfle"
        client.mealsGet().continueWith { (task) -> Any? in
            self.showResult(task: task as! AWSTask<AnyObject>)
        }
    }
    
    func showResult(task: AWSTask<AnyObject>) {
        if let error = task.error {
            print("Error: \(error)")
        } else if let result = task.result{
            let res = result as! Array<Any>
            print("NSDictionary: \(res)")
        }
    }
    
    func refresh() {
        self.user?.getDetails().continueOnSuccessWith { (task) -> AnyObject? in
            DispatchQueue.main.async(execute: {
                self.response = task.result
                self.title = self.user?.username
                self.tableView.reloadData()
            })
            return nil
        }
    }
}

