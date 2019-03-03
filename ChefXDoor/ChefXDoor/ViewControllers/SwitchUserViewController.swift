//
//  SwitchUserViewController.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 2/7/19.
//  Copyright © 2019 ChefXDoor. All rights reserved.
//

import Foundation
import PKHUD

class SwitchUserViewController: UIViewController {
    
    @IBOutlet weak var foodieButton: UIButton!
    @IBOutlet weak var chefButton: UIButton!
    @IBOutlet weak var driverButton: UIButton!
    
    @IBOutlet weak var buttonStackView: UIStackView!
    override func viewDidLoad() {
        self.view.backgroundColor = CXDAppearance.primaryBackgroundColor()
        buttonStackView.backgroundColor = CXDAppearance.primaryBackgroundColor()
        
        foodieButton.backgroundColor = CXDAppearance.primaryColor()
        foodieButton.setTitleColor(UIColor.white, for: .normal)
        
        chefButton.backgroundColor = CXDAppearance.primaryColor()
        chefButton.setTitleColor(UIColor.white, for: .normal)
        
        driverButton.backgroundColor = CXDAppearance.primaryColor()
        driverButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func foodieButtonTapped(_ sender: Any) {
       let leftMenuViewController = panel?.left as! LeftMenuViewController
       leftMenuViewController.currentUserType = .Chef
       leftMenuViewController.reloadData()
        
//        HUD.show(.progress, onView: self.view)
//        CXDApiServiceController.awsGetFromEndPoint(urlString: "/meals/recommended", queryParametersDict: ["lat" : 38.994373, "long" : -77.029778, "distance" : 10, "page" : 0, "sort":"price"], pathParametersDict: nil, classType: CXDMeal.self).continueWith { (task) -> Any? in
//
//            DispatchQueue.main.async {
//                HUD.hide()
//                if let error = task.error {
//                    print("Error: \(error)")
//                } else if let result = task.result{
//                    let res = result as! Array<CXDMeal>
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    let recommendationsViewController = storyboard.instantiateViewController(withIdentifier: "RecommendationsViewController") as! RecommendationsViewController
//                    recommendationsViewController.recommendedMeals = res
//                    let recommendationsNavVC = UINavigationController(rootViewController: recommendationsViewController)
//
//                    self.panel?.center(recommendationsNavVC)
//                }
//            }
//        }
        
        let storyboard = UIStoryboard(name: "Chef", bundle: nil)
        let recommendationsViewController = storyboard.instantiateViewController(withIdentifier: "CXDAddReceipeViewController") as! CXDAddReceipeViewController
        //recommendationsViewController.recommendedMeals = res
        let recommendationsNavVC = UINavigationController(rootViewController: recommendationsViewController)
        
        self.panel?.center(recommendationsNavVC)
    }
    
}
