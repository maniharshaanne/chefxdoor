//
//  ChefDetailViewController.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 10/17/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import UIKit
import PKHUD
import AWSCognito
import Kingfisher

class ChefDetailViewController: UIViewController, UITabBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var chef:CXDChef?
    var chefMeals:[CXDMeal]?
    @IBOutlet weak var mealsTableView: UITableView!
    @IBOutlet weak var mealsTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var chefNameLabel: UILabel!
    @IBOutlet weak var chefCategoriesLabel: UILabel!
    @IBOutlet weak var chefSloganLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var reviewsImageView: UIImageView!
    @IBOutlet weak var chefIntroductionNotesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CXDApiServiceController.awsGetFromEndPoint(urlString: "/meals", queryParametersDict: ["lat" : 38.994373, "long" : -77.029778, "distance" : 10, "page" : 0, "sort":"rating", "chef_id": 2], pathParametersDict: nil, classType: CXDMeal.self).continueWith { (task) -> Any? in
            DispatchQueue.main.async {
                if let error = task.error {
                    print("Error: \(error)")
                } else if let result = task.result{
                    let res = result as! Array<CXDMeal>
                    self.chefMeals = res
                    self.mealsTableView.reloadData()
                    self.mealsTableView.layoutIfNeeded()
                    self.mealsTableViewHeightConstraint.constant = self.mealsTableView.contentSize.height
                }
            }
        }

        mealsTableView.rowHeight = UITableViewAutomaticDimension
        mealsTableView.estimatedRowHeight = 90
        
        mealsTableView.register(UINib.init(nibName: "CXDMealTableViewCell", bundle: Bundle.init(for: CXDMealTableViewCell.self)), forCellReuseIdentifier: "CXDMealTableViewCell")
        

        
        chefNameLabel.text = chef?.username
        chefCategoriesLabel.text = chef?.categories
        chefSloganLabel.text = chef?.slogan
        reviewsLabel.text = (chef?.reviewCount?.stringValue)! + " reviews"
        profileImageView.kf.cancelDownloadTask()
        let resource = ImageResource(downloadURL: URL.init(string: (chef?.imageUrl!)!)!)
        profileImageView.kf.setImage(with: resource)
        reviewsImageView.image = CXDUtility.sharedUtility.imageFor(rating : (chef?.rating?.intValue)!)
        
        chefIntroductionNotesLabel.layer.borderWidth = 2
        chefIntroductionNotesLabel.layer.borderColor = UIColor(red: 246/256, green: 102/256, blue: 71/256, alpha: 1).cgColor
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chefMeals?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mealsTableView.dequeueReusableCell(withIdentifier: "CXDMealTableViewCell") as! CXDMealTableViewCell
        cell.updateInfo(meal: chefMeals![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        HUD.flash(.progress, onView: navigationController?.view)
        CXDApiServiceController.awsGetFromEndPoint(urlString: "/meals/1", queryParametersDict: nil, pathParametersDict: nil, classType: CXDMeal.self).continueWith { (task) -> Any? in
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
