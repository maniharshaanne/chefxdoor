//
//  MealsTableViewController.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 9/16/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import UIKit
import PKHUD
import AWSCognito

class MealsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet public weak var mealsTableView:UITableView!
    public var mealsArray:Array<CXDMeal>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItems = customRightBarButtonItems()
        mealsTableView.rowHeight = UITableViewAutomaticDimension
        mealsTableView.estimatedRowHeight = 200
        mealsTableView.register(UINib.init(nibName: "CXDMealTableViewCell", bundle: Bundle.init(for: CXDMealTableViewCell.self)), forCellReuseIdentifier: "CXDMealTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mealsTableView.dequeueReusableCell(withIdentifier: "CXDMealTableViewCell") as! CXDMealTableViewCell
        let meal =  mealsArray![indexPath.row]
        cell.updateInfo(meal: meal)
        cell.favouriteMealSelected = {
            CXDApiServiceController.awsPostForEndPoint(urlString: "/users/41/favoritemeals", queryParametersDict: nil, pathParametersDict: ["user_id" : 41], body: meal, classType: CXDFavoriteMeal.self)
        }
        cell.favoriteMealUnSelected = {
            if let mealId = meal.id?.intValue
            {
                let pathParameters = ["user_id": 41, "meal_id": mealId]
                let deleteUrlString = "/users/41/favoritemeals/\(mealId)"

                CXDApiServiceController.awsDeleteForEndPoint(urlString: deleteUrlString, queryParametersDict: nil, pathParametersDict: pathParameters)
            }

        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        HUD.flash(.progress, onView: navigationController?.view)
        let meal = mealsArray![indexPath.row]
        CXDApiServiceController.awsGetFromEndPoint(urlString: "/meals/\(meal.id?.intValue ?? 0)" , queryParametersDict: nil, pathParametersDict: nil, classType: CXDMeal.self).continueWith { (task) -> Any? in
            DispatchQueue.main.async {
                HUD.hide()
                self.showResult(task: task )
            }
        }
    }
    
    func showResult(task: AWSTask<AnyObject>) {
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
