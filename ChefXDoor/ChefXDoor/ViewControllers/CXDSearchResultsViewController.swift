//
//  CXDSearchResultsViewController.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 11/4/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import UIKit
import PKHUD

class CXDSearchResultsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchResultsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var chefs: [CXDChef]?
    var meals: [CXDMeal]?
    
//    enum searchType {
//        case chefType
//        case mealType
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultsTableView.register(UINib.init(nibName: "CXDMealTableViewCell", bundle: nil), forCellReuseIdentifier: "CXDMealTableViewCell")
        searchResultsTableView.register(UINib.init(nibName: "CXDChefTableViewCell", bundle: nil), forCellReuseIdentifier: "CXDChefTableViewCell")
        
        self.navigationController?.navigationBar.barTintColor = UIColor.darkGray
        self.navigationItem.leftBarButtonItem = self.menuLeftBarButton()
        
        searchResultsTableView.keyboardDismissMode = .onDrag
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let selectedIndex = searchBar.selectedScopeButtonIndex
//        let selectedScopeTitle = searchBar.scopeButtonTitles![selectedIndex]
        if selectedIndex == 0 {
            return chefs?.count ?? 0
        } else {
            return meals?.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedIndex = searchBar.selectedScopeButtonIndex

        if selectedIndex == 0 {
            let cell = searchResultsTableView.dequeueReusableCell(withIdentifier: "CXDChefTableViewCell") as! CXDChefTableViewCell
            cell.updateInfo(chefInfo: chefs![indexPath.row])
            return cell
        } else {
            let cell = searchResultsTableView.dequeueReusableCell(withIdentifier: "CXDMealTableViewCell") as! CXDMealTableViewCell
            cell.updateInfo(meal: meals![indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedIndex = searchBar.selectedScopeButtonIndex

        if selectedIndex == 0 {
            
        } else {
            HUD.flash(.progress, onView: navigationController?.view)
            CXDApiServiceController.awsGetFromEndPoint(urlString: "/meals/1", queryParametersDict: nil, pathParametersDict: nil, classType: CXDMeal.self).continueWith { (task) -> Any? in
                DispatchQueue.main.async {
                    HUD.hide()
                    if let error = task.error {
                        print("Error: \(error)")
                    } else if let result = task.result{
                        
                        let res = result as! CXDMeal
                        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.init(for: MealDetailViewController.self))
                        let mealDetailViewController = storyboard.instantiateViewController(withIdentifier: "MealDetailViewController") as! MealDetailViewController
                        mealDetailViewController.meal = res
                        self.navigationController!.pushViewController(mealDetailViewController, animated: true)
                    }
                }
            }
        }
    }
    
//    func showResult(task: AWSTask<AnyObject>) {
//        if let error = task.error {
//            print("Error: \(error)")
//        } else if let result = task.result{
//            
//            let res = result as! CXDMeal
//            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.init(for: MealDetailViewController.self))
//            let mealDetailViewController = storyboard.instantiateViewController(withIdentifier: "MealDetailViewController") as! MealDetailViewController
//            mealDetailViewController.meal = res
//            self.navigationController!.pushViewController(mealDetailViewController, animated: true)
//        }
//    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let selectedIndex = searchBar.selectedScopeButtonIndex
        if let searchString = searchBar.text
        {
            if selectedIndex == 0 {
                CXDApiServiceController.awsGetFromEndPoint(urlString: "/search/chefs", queryParametersDict: ["lat":38.994373, "long":-77.029778, "distance":10, "page":0, "sort":"rating", "keyword": searchString], pathParametersDict: nil, classType: CXDChef.self).continueWith(block: { (task) -> Any? in
                    
                    DispatchQueue.main.async {
                        if let error = task.error {
                            
                        } else if let result = task.result as? [CXDChef] {
                            self.chefs = result
                            self.searchResultsTableView.reloadData()
                        }
                    }
                })
            } else {
                CXDApiServiceController.awsGetFromEndPoint(urlString: "/search/meals", queryParametersDict: ["lat":38.994373, "long":-77.029778, "distance":10, "page":0, "sort":"rating", "keyword": searchString], pathParametersDict: nil, classType: CXDMeal.self).continueWith(block: { (task) -> Any? in
                    
                    DispatchQueue.main.async {
                        if let error = task.error {
                            
                        } else if let result = task.result as? [CXDMeal] {
                            self.meals = result
                            self.searchResultsTableView.reloadData()
                        }
                    }
                })
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        searchResultsTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text = nil
        searchResultsTableView.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
