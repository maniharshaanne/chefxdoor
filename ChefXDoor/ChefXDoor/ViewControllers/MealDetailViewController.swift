//
//  MealDetailViewController.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 9/23/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import PKHUD
import MIBlurPopup
import FaveButton

class MealDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FSPagerViewDelegate, FSPagerViewDataSource,FaveButtonDelegate {

    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var chefNameLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var reviewsTableView: UITableView!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var favButtonView: UIView!
    
    @IBOutlet weak var imagePagerView: FSPagerView!{
        didSet {
            self.imagePagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    
    @IBOutlet weak var pageControl: FSPageControl! {
        didSet {
            self.pageControl.numberOfPages = meal?.photos?.count ?? 0
            self.pageControl.contentHorizontalAlignment = .center
            self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            self.pageControl.hidesForSinglePage = true
        }
    }
    
    public var userReviews:Array<CXDMealReview>?
    public var meal:CXDMeal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mealNameLabel.text = meal?.name
        chefNameLabel.text = meal?.chefUsername
        reviewsLabel.text = (meal?.reviewCount?.stringValue)! + "reviews"
        reviewsTableView.estimatedRowHeight = 130
        reviewsTableView.rowHeight = UITableViewAutomaticDimension
        
        reviewsTableView.register(UINib.init(nibName: "CXDMealDetailTableViewCell", bundle: Bundle.init(for: CXDMealDetailTableViewCell.self)), forCellReuseIdentifier: "CXDMealDetailTableViewCell")
        
        let faveButton = FaveButton(
            frame: CGRect(x:0, y:0, width: 44, height: 44),
            faveIconNormal: UIImage(named: "Heart")
        )
        faveButton.delegate = self
        favButtonView.addSubview(faveButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        HUD.flash(.progress, onView: self.reviewsTableView)
        CXDApiServiceController.awsGetFromEndPoint(urlString: "/meals/1/reviews", queryParametersDict: ["page" : 0], pathParametersDict: nil, classType: CXDMealReview.self).continueWith { (task) -> Any? in
            DispatchQueue.main.async {
                HUD.hide()
                self.userReviews = task.result as! Array<CXDMealReview>
                self.reviewsTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.userReviews?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = reviewsTableView.dequeueReusableCell(withIdentifier: "CXDMealDetailTableViewCell") as! CXDMealDetailTableViewCell
        cell.updateCell(mealReview: userReviews![indexPath.row])
        return cell
    }
    
    //PagerView Delegate
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return meal?.photos?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.kf.cancelDownloadTask()
        if let imageUrl = meal?.photos![index].imageUrl
        {
            let resource = ImageResource(downloadURL: URL.init(string: imageUrl)!)
            cell.imageView?.kf.setImage(with: resource)
            cell.imageView?.contentMode = .scaleAspectFill
        }
        return cell
    }

    @IBAction func addToCartButtonPressed(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.init(for: ReceipeAddedToCartViewController.self))
        let receipeAddedToCartViewController = storyboard.instantiateViewController(withIdentifier: "ReceipeAddedToCartViewController") as! ReceipeAddedToCartViewController
        let PopupVC = setPopupVC(storyboradID:"Main",viewControllerID:"ReceipeAddedToCartViewController")
        PopupVC.popupCustomAlign = CGPoint(x: 50, y: 25)
        PopupVC.popupAnimation = .normal
        PopupVC.popupSize = CGSize(width: 350, height: 450)

        self.presentPopup(controller: PopupVC, completion: nil)
        
    }
    
    func faveButton(_ faveButton: FaveButton, didSelected selected: Bool) {
        
    }
}
