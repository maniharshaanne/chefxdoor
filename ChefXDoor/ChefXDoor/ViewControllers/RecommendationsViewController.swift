//
//  RecommendationsViewController.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 9/3/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import UIKit
import AWSCognito
import PKHUD

class RecommendationsViewController : UIViewController,UITableViewDelegate,UITableViewDataSource  {
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var categoriesView: UIView!
    @IBOutlet weak var onlineChefsView:UIView!
    @IBOutlet public var recommendedMealsTableView:UITableView!
    @IBOutlet weak var searchView: UIView!
    
    public var recommendedMeals:Array<CXDMeal>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = CXDAppearance.primaryBackgroundColor()
        recommendedMealsTableView.backgroundColor = CXDAppearance.primaryBackgroundColor()
        recommendedMealsTableView.rowHeight = UITableViewAutomaticDimension
        recommendedMealsTableView.estimatedRowHeight = 200
        recommendedMealsTableView.register(UINib.init(nibName: "CXDMealTableViewCell", bundle: Bundle.init(for: CXDMealTableViewCell.self)), forCellReuseIdentifier: "CXDMealTableViewCell")
        
        self.navigationController?.navigationBar.barTintColor = CXDAppearance.primaryBackgroundDarkColor()
        self.navigationItem.rightBarButtonItems = customRightBarButtonItems()
        self.navigationItem.leftBarButtonItem = menuLeftBarButton()
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        let titleImageView = UIImageView(image: UIImage(named: "cxd-logo"))
        titleImageView.frame = CGRect(x: 0, y: 0, width: titleView.frame.width, height: titleView.frame.height)
        titleView.addSubview(titleImageView)
        navigationItem.titleView = titleView
        
        categoriesView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(RecommendationsViewController.categoriesViewTapped)))
        onlineChefsView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(RecommendationsViewController.onlineChefsViewTapped)))
        
        searchView.layer.borderWidth = 1
        searchView.layer.cornerRadius = 5
        searchView.layer.borderColor = CXDAppearance.primaryColor().cgColor
        searchView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(searchViewTapped)))
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        if appdelegate.isUpdateTokenRequired
        {
            self.updateUserToken()
        } else {
            self.getMeals(token: "")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recommendedMeals?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recommendedMealsTableView.dequeueReusableCell(withIdentifier: "CXDMealTableViewCell") as! CXDMealTableViewCell
        cell.updateInfo(meal: recommendedMeals![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        HUD.flash(.progress, onView: navigationController?.view)
        CXDApiServiceController.awsGetFromEndPoint(urlString: "/meals/1", queryParametersDict: nil, pathParametersDict: nil, classType: CXDMeal.self).continueWith { (task) -> Any? in
            DispatchQueue.main.async {
                HUD.hide()
                if let error = task.error {
                    print("Error: \(error)")
                } else if let result = task.result {
                    
                    let res = result as! CXDMeal
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.init(for: MealDetailViewController.self))
                    let mealDetailViewController = storyboard.instantiateViewController(withIdentifier: "MealDetailViewController") as! MealDetailViewController
                    mealDetailViewController.meal = res
                    self.navigationController!.pushViewController(mealDetailViewController, animated: true)
                }
            }
        }
    }
    
    func updateUserToken()  {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let user = appDelegate.currentUser
        {
            user.getSession().continueWith(block: { (userSession) -> Any? in
                DispatchQueue.main.async {
                    if let getSessionResult = userSession.result
                    {
                        appDelegate.setupAWSConfiguration(userSession: getSessionResult)
                        self.getMeals(token: "")
                    }
                }
            })
        } else {
            //Load Login Screen
        }
    }

    func getMeals(token:String)
    {
        HUD.show(.progress, onView: self.navigationController?.view)

        CXDApiServiceController.awsGetFromEndPoint(urlString: "/meals/recommended", queryParametersDict: ["lat" : 38.994373, "long" : -77.029778, "distance" : 10, "page" : 0, "sort":"price"], pathParametersDict: nil, classType: CXDMeal.self).continueWith { (task) -> Any? in
            
            DispatchQueue.main.async {
                HUD.hide()
                if let error = task.error {
                    print("Error: \(error)")
                } else if let result = task.result {
                    let res = result as! Array<CXDMeal>
                    self.recommendedMeals = res
                    self.recommendedMealsTableView.reloadData()
                    self.recommendedMealsTableView.layoutIfNeeded()
                    self.tableViewHeightConstraint.constant = self.recommendedMealsTableView.contentSize.height + 10
                }
            }
        }
    }
    
    @objc func categoriesViewTapped()
    {
        HUD.show(.progress, onView: self.navigationController?.view)

        CXDApiServiceController.awsGetFromEndPoint(urlString: "/meals/categories", queryParametersDict: ["lat" : 38.99437, "long" : -77.02977, "distance" : 10], pathParametersDict: nil, classType: CXDMealCategory.self).continueWith { (task) -> Any? in

            DispatchQueue.main.async {
                HUD.hide()
                if let error = task.error {
                    print("Error: \(error)")
                } else if let result = task.result{
                    
                    let res = result as! Array<CXDMealCategory>
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.init(for: MealCategoriesViewController.self))
                    let mealCategoriesViewController = storyboard.instantiateViewController(withIdentifier: "MealCategoriesViewController") as! MealCategoriesViewController
                    mealCategoriesViewController.categoryArray = res
                    self.navigationController!.pushViewController(mealCategoriesViewController, animated: true)
                    //self.present(mealCategoriesViewController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func onlineChefsViewTapped()
    {
        HUD.show(.progress, onView: self.navigationController?.view)

        CXDApiServiceController.awsGetFromEndPoint(urlString: "/users/chefs", queryParametersDict: ["lat" : 38.99437, "long" : -77.02977, "distance" : 10 ,"page" : 0, "sort" : "rating"], pathParametersDict: nil, classType: CXDChef.self).continueWith { (task) -> Any? in
            
            DispatchQueue.main.async {
                HUD.hide()
                if let error = task.error {
                    print("Error: \(error)")
                } else if let result = task.result{
                    
                    let res = result as! Array<CXDChef>
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.init(for: CXDChefsOnlineTableViewController.self))
                    let onlineChefsViewController = storyboard.instantiateViewController(withIdentifier: "CXDChefsOnlineTableViewController") as! CXDChefsOnlineTableViewController
                    onlineChefsViewController.onlineChefs = res
                    self.navigationController!.pushViewController(onlineChefsViewController, animated: true)
                }
            }
        }
    }
    
    @objc func searchViewTapped(sender: UIBarButtonItem) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let searchResultsViewController = storyBoard.instantiateViewController(withIdentifier: "CXDSearchResultsViewController") as! CXDSearchResultsViewController
        let searchResultsNavigationViewController = UINavigationController(rootViewController: searchResultsViewController)
        panel?.configs.changeCenterPanelAnimated = false
        panel?.center(searchResultsNavigationViewController)
    }
}

extension RecommendationsViewController {

}
