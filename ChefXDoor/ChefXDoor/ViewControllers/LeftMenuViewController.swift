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
    
    enum userType {
        case Foodie, Chef, Driver
    }
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var avatarImageView: UIImageView!
    @IBOutlet fileprivate weak var avatarImageViewCenterXConstraint: NSLayoutConstraint!
    var menuItems:Array<CXDAppMenuItem>?
    var currentUserType: userType?
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentUserType = .Foodie
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

        var menuItems: Array<CXDAppMenuItem> = []
        
        switch currentUserType {
        case .Foodie?:
             menuItems = foodieMenuItems()
            break
        case .Chef?:
            menuItems = chefMenuItems()
            break
        case .Driver?:
            break
        default:
            break
        }
        
        return menuItems
    }
    
    func foodieMenuItems() -> [CXDAppMenuItem] {
        let exploreFoodMenuItem = CXDAppMenuItem(title: "Explore Food", imageName: "ExploreFood", menuType: .ExploreFood)
        let myFavouritesMenuItem = CXDAppMenuItem(title: "My Favourites", imageName: "Heart", menuType: .MyFavourites)
        let orderHistoryMenuItem = CXDAppMenuItem(title: "Order History", imageName: "OrderHistory", menuType: .OrderHistory)
        let paymentMethodsMenuItem = CXDAppMenuItem(title: "Payment Methods", imageName: "PaymentMethods", menuType: .PaymentMethods)
        let searchMenuItem = CXDAppMenuItem(title: "Search ChefXDoor", imageName: "SearchChefxdoor", menuType: .Search)
        let helpMenuItem = CXDAppMenuItem(title: "Help", imageName: "Help", menuType: .Help)
        let switchUserMenuItem = CXDAppMenuItem(title: "Switch User", imageName: "Help", menuType: .SwitchUser)
        let logoutMenuItem = CXDAppMenuItem(title: "Logout", imageName: "Help", menuType: .Logout)
        
        let menuItemsArray = [exploreFoodMenuItem, myFavouritesMenuItem, orderHistoryMenuItem, paymentMethodsMenuItem, searchMenuItem, helpMenuItem, switchUserMenuItem, logoutMenuItem]
        
        return menuItemsArray
    }
    
    func chefMenuItems() -> Array<CXDAppMenuItem> {
        let menuMenuItem = CXDAppMenuItem(title: "Menu", imageName: "ExploreFood", menuType: .Menu)
        let ordersMenuItem = CXDAppMenuItem(title: "Orders", imageName: "ExploreFood", menuType: .Orders)
        let paymentHistoryMenuItem = CXDAppMenuItem(title: "View Payment Info", imageName: "ExploreFood", menuType: .PaymentInfo)
       
        let menuItemsArray = [menuMenuItem, ordersMenuItem, paymentHistoryMenuItem]
        
        return menuItemsArray
    }
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        //let currentUser = result as! CXDCurrentUser
        let storyBoard = UIStoryboard (name: "Main", bundle: nil)
        let userProfileViewController = storyBoard.instantiateViewController(withIdentifier: "CXDUserProfileViewController") as! CXDUserProfileViewController
        //userProfileViewController.currentLoggedUser = currentUser
        let userProfileNavigationController = UINavigationController(rootViewController: userProfileViewController)
        self.panel?.center(userProfileNavigationController)
    }
    
    func reloadData()  {
        menuItems = prepareMenuItems()
        self.tableView.reloadData()
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
                HUD.show(.progress, onView: self.view)
                CXDApiServiceController.awsGetFromEndPoint(urlString: "/meals/recommended", queryParametersDict: ["lat" : 38.994373, "long" : -77.029778, "distance" : 10, "page" : 0, "sort":"price"], pathParametersDict: nil, classType: CXDMeal.self).continueWith { (task) -> Any? in
                    
                    DispatchQueue.main.async {
                        HUD.hide()
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
        
        case .MyFavourites? :
            
            HUD.show(.progress, onView: self.view)
            CXDApiServiceController.awsGetFromEndPoint(urlString: "/users/41/favoritemeals", queryParametersDict: nil, pathParametersDict: ["user_id" : 41], classType: CXDFavoriteMeal.self).continueWith(block: { (task) -> Any? in
                
                DispatchQueue.main.async {
                    HUD.hide()
                    if let error = task.error
                    {
                        let alert = UIAlertController(title: "Attention", message: "Error while retreiving favourite meals", preferredStyle: UIAlertControllerStyle.alert)
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                        alert.addAction(okAction)
                    }
                    else
                    {
                        if let result = task.result as? [CXDFavoriteMeal]
                        {
                            
                        }
                    }
                }
            })
            break
            
        case .Search? :
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let searchResultsViewController = storyBoard.instantiateViewController(withIdentifier: "CXDSearchResultsViewController") as! CXDSearchResultsViewController
            let searchResultsNavigationViewController = UINavigationController(rootViewController: searchResultsViewController)
            panel?.center(searchResultsNavigationViewController)
            break
       
        case .SwitchUser? :
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let switchUserViewController = storyBoard.instantiateViewController(withIdentifier: "SwitchUserViewController") as! SwitchUserViewController
            panel?.center(switchUserViewController)
            break
            
        case .Logout? :
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let userPool = appDelegate.cxdIdentityUserPool
            let user = userPool?.currentUser()
            user?.signOut()
            user?.getSession()
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

