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
    @IBOutlet public var recommendedMealsTableView:UITableView!
    public var recommendedMeals:Array<CXDMeal>?

//    convenience init() {
//        self.init()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.navigationBar.isHidden = true
        recommendedMealsTableView.rowHeight = UITableViewAutomaticDimension
        recommendedMealsTableView.estimatedRowHeight = 90
        recommendedMealsTableView.register(UINib.init(nibName: "CXDMealTableViewCell", bundle: Bundle.init(for: CXDMealTableViewCell.self)), forCellReuseIdentifier: "CXDMealTableViewCell")
        recommendedMealsTableView.reloadData()
        recommendedMealsTableView.layoutIfNeeded()
        tableViewHeightConstraint.constant = recommendedMealsTableView.contentSize.height
        
        categoriesView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(RecommendationsViewController.categoriesViewTapped)))
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
    
    @objc func categoriesViewTapped()
    {
        CXDApiServiceController.awsGetFromEndPoint(urlString: "/meals/categories", queryParametersDict: ["lat" : 38.99437, "long" : -77.02977, "distance" : 10], pathParametersDict: nil, classType: CXDMealCategory.self).continueWith { (task) -> Any? in

            DispatchQueue.main.async {
                self.showResult(task: task )
            }
        }
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let mealCategoriesViewController = storyboard.instantiateViewController(withIdentifier: "MealCategoriesViewController") as! MealCategoriesViewController
//        mealCategoriesViewController.categoryArray = nil
//        self.navigationController!.pushViewController(mealCategoriesViewController, animated: true)
    }
    
    func showResult(task: AWSTask<AnyObject>) {
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
