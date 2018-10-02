//
//  LeftMenuViewController.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 7/28/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import UIKit

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
        tableView.rowHeight = 60
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width/2
    }
    
    deinit{
        print()
    }
    
    func prepareMenuItems() -> Array<CXDAppMenuItem>
    {
        var exploreFoodMenuItem = CXDAppMenuItem(title: "EXPLORE FOOD", imageName: "ExploreFood", menuType: .ExploreFood)
        var myFavouritesMenuItem = CXDAppMenuItem(title: "MY FAVORITES", imageName: "MyFavorites", menuType: .MyFavourites)
        var orderHistoryMenuItem = CXDAppMenuItem(title: "ORDER HISTORY", imageName: "OrderHistory", menuType: .OrderHistory)
        var paymentMethodsMenuItem = CXDAppMenuItem(title: "PAYMENT METHODS", imageName: "PaymentMethods", menuType: .PaymentMethods)
        var searchMenuItem = CXDAppMenuItem(title: "SEARCH CHEFXDOOR", imageName: "SearchChefxdoor", menuType: .Search)
        var helpMenuItem = CXDAppMenuItem(title: "HELP", imageName: "Help", menuType: .Help)
        
        var menuItemsArray = [exploreFoodMenuItem, myFavouritesMenuItem, orderHistoryMenuItem, paymentMethodsMenuItem, searchMenuItem, helpMenuItem]
        
        return menuItemsArray
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
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let menuContainerViewController = self.menuContainerViewController else {
//            return
//        }
//
//        menuContainerViewController.selectContentViewController(menuContainerViewController.contentViewControllers[indexPath.row])
//        menuContainerViewController.hideSideMenu()
//    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
}

