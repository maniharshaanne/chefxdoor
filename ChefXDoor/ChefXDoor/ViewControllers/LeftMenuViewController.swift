//
//  LeftMenuViewController.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 7/28/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import UIKit
import FAPanels
import PKHUD

/**
 Menu controller is responsible for creating its content and showing/hiding menu using 'menuContainerViewController' property.
 */
class LeftMenuViewController: UIViewController {
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var avatarImageView: UIImageView!
    @IBOutlet fileprivate weak var avatarImageViewCenterXConstraint: NSLayoutConstraint!
    var menuItems:Array<CXDAppMenuItem>?
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuItems = prepareMenuItems()
        // Select the initial row
        //tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: UITableViewScrollPosition.none)
        tableView.rowHeight = 50
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width/2
    }
    
    deinit{
        print()
    }
    
    func prepareMenuItems() -> Array<CXDAppMenuItem>
    {
        let exploreFoodMenuItem = CXDAppMenuItem(title: "EXPLORE FOOD", imageName: "ExploreFood", menuType: .ExploreFood)
        let myFavouritesMenuItem = CXDAppMenuItem(title: "MY FAVORITES", imageName: "Heart", menuType: .MyFavourites)
        let orderHistoryMenuItem = CXDAppMenuItem(title: "ORDER HISTORY", imageName: "OrderHistory", menuType: .OrderHistory)
        let paymentMethodsMenuItem = CXDAppMenuItem(title: "PAYMENT METHODS", imageName: "PaymentMethods", menuType: .PaymentMethods)
        let searchMenuItem = CXDAppMenuItem(title: "SEARCH CHEFXDOOR", imageName: "SearchChefxdoor", menuType: .Search)
        let helpMenuItem = CXDAppMenuItem(title: "HELP", imageName: "Help", menuType: .Help)
        let logoutMenuItem = CXDAppMenuItem(title: "Logout", imageName: "Help", menuType: .Logout)

        let menuItemsArray = [exploreFoodMenuItem, myFavouritesMenuItem, orderHistoryMenuItem, paymentMethodsMenuItem, searchMenuItem, helpMenuItem, logoutMenuItem]
        
        return menuItemsArray
    }
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        HUD.show(.progress, onView: self.view)
        CXDApiServiceController.awsGetFromEndPoint(urlString: "/users/currentuser", queryParametersDict: nil, pathParametersDict: nil, classType: CXDCurrentUser.self).continueWith { (task) -> Any? in
            
            DispatchQueue.main.async {
                HUD.hide()
                if let error = task.error {
                    print("error : \(error)")
                } else if let result = task.result {
                    let currentUser = result as! CXDCurrentUser
                    let storyBoard = UIStoryboard (name: "Main", bundle: nil)
                    let userProfileViewController = storyBoard.instantiateViewController(withIdentifier: "CXDUserProfileViewController") as! CXDUserProfileViewController
                    userProfileViewController.currentUser = currentUser
                    let userProfileNavigationController = UINavigationController(rootViewController: userProfileViewController)
                    self.panel?.center(userProfileNavigationController)
                }
            }
        }
    }
}

extension LeftMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CXDLeftMenuTableCell.self), for: indexPath) as? CXDLeftMenuTableCell else {
            preconditionFailure("Unregistered table view cell")
        }
        
        let menuItem = menuItems![indexPath.row]
        cell.updateInfo(menuItem: menuItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let menuItem:CXDAppMenuItem = menuItems![indexPath.row]
        
        switch menuItem.menuType
        {
            case .ExploreFood?:
                CXDApiServiceController.awsGetFromEndPoint(urlString: "/meals/recommended", queryParametersDict: ["lat" : 38.994373, "long" : -77.029778, "distance" : 10, "page" : 0, "sort":"price"], pathParametersDict: nil, classType: CXDMeal.self).continueWith { (task) -> Any? in
                    
                    DispatchQueue.main.async {
                        if let error = task.error {
                            print("Error: \(error)")
                        } else if let result = task.result{
                            let res = result as! Array<CXDMeal>
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let recommendationsViewController = storyboard.instantiateViewController(withIdentifier: "RecommendationsViewController") as! RecommendationsViewController
                            recommendationsViewController.recommendedMeals = res
                            let recommendationsNavVC = UINavigationController(rootViewController: recommendationsViewController)
                            
                            self.panel?.center(recommendationsNavVC)
                        }
                    }
                }

            break
            
            case .OrderHistory? :
               
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let pastOrderVC: PastOrdersViewController = mainStoryboard.instantiateViewController(withIdentifier: "PastOrdersViewController") as! PastOrdersViewController
                let pastOrderNavVC = UINavigationController(rootViewController: pastOrderVC)
                
                panel?.center(pastOrderNavVC)
                
            break
            
        case .Logout? :
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let userPool = appDelegate.cxdIdentityUserPool
            let user = userPool?.currentUser()
            user?.signOut()
            break
            
            default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    
}

