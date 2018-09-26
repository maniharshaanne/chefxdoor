//
//  StartScreenViewController.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 6/14/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import AWSCognito
import AWSCognitoIdentityProvider
import PKHUD

class StartScreenViewController: UIViewController {
    
    var response: AWSCognitoIdentityUserGetDetailsResponse?
    var user: AWSCognitoIdentityUser?
    var pool: AWSCognitoIdentityUserPool?
    
    convenience init() {
        self.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.navigationBar.isHidden = true
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
  
    @IBAction func testApi(_ sender: Any) {
        self.getMeals(token: "")
 
    }
    
    @IBAction func signOut(_ sender: AnyObject) {
        self.user?.signOut()
        self.title = nil
        self.response = nil
        self.refresh()
    }
    
    func getMeals(token:String)
    {
        CXDApiServiceController.awsGetFromEndPoint(urlString: "/meals/recommended", queryParametersDict: ["lat" : 38.994373, "long" : -77.029778, "distance" : 10, "page" : 0, "sort":"price"], pathParametersDict: nil, classType: CXDMeal.self).continueWith { (task) -> Any? in
            
            DispatchQueue.main.async {
                self.showResult(task: task )
            }
        }
    }

    func showResult(task: AWSTask<AnyObject>) {
        if let error = task.error {
            print("Error: \(error)")
        } else if let result = task.result{
            let res = result as! Array<CXDMeal>
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let recommendationsViewController = storyboard.instantiateViewController(withIdentifier: "RecommendationsViewController") as! RecommendationsViewController
            recommendationsViewController.recommendedMeals = res
            self.navigationController?.pushViewController(recommendationsViewController, animated: true)
        }
    }
    
    func refresh() {
        HUD.flash(.progress, onView: navigationController?.view)
        self.user?.getDetails().continueOnSuccessWith { (task) -> AnyObject? in
            DispatchQueue.main.async(execute: {
                HUD.hide()
                self.response = task.result
                self.title = self.user?.username
            })
            return nil
        }
    }
}

