//
//  MealCategoriesViewController.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 9/16/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import UIKit
import AWSCognito

class MealCategoriesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet public weak var categoryCollectionView:UICollectionView!
    public var categoryArray:Array<CXDMealCategory>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItems = customRightBarButtonItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "CXDMealCategoryCollectionViewCell", for: indexPath) as! CXDMealCategoryCollectionViewCell
        cell.updateInfo(category: categoryArray![indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        CXDApiServiceController.awsGetFromEndPoint(urlString: "/meals/categories/1", queryParametersDict: ["lat" : 38.99437, "long" : -77.02977, "distance" : 10, "page" : 0, "sort" : "rating"], pathParametersDict: nil, classType: CXDMeal.self).continueWith { (task) -> Any? in
            
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
            let mealsTableViewController = storyboard.instantiateViewController(withIdentifier: "MealsTableViewController") as! MealsTableViewController
            mealsTableViewController.mealsArray = res
            navigationController?.pushViewController(mealsTableViewController, animated: true)
        }
    }
}
