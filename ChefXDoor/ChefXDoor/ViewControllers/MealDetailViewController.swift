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
import AWSCognito

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
    @IBOutlet weak var tableViewHeightConstraint:NSLayoutConstraint!
    @IBOutlet weak var chefDescriptionImage: UIImageView!
    @IBOutlet weak var chefDescriptionTitleLabel: UILabel!
    @IBOutlet weak var chefDescriptionLabel: UILabel!
    @IBOutlet weak var ingredientsImage: UIImageView!
    @IBOutlet weak var ingredientsTitleLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var totalReviewsImageView: UIImageView!
    @IBOutlet weak var totalReviewsLabel: UILabel!
    @IBOutlet weak var preparationTimeView: UIView!
    @IBOutlet weak var totalCostView: UIView!
    
    @IBOutlet weak var imagePagerView: FSPagerView!{
        didSet {
            self.imagePagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.imagePagerView.delegate = self
            self.imagePagerView.dataSource = self
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
        
        self.navigationItem.rightBarButtonItems = self.customRightBarButtonItems()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        mealNameLabel.text = meal?.name
        chefNameLabel.text = meal?.chefUsername
        reviewsLabel.text = (meal?.reviewCount?.stringValue)! + "reviews"
        reviewsTableView.estimatedRowHeight = 130
        reviewsTableView.rowHeight = UITableViewAutomaticDimension
        
        reviewsTableView.register(UINib.init(nibName: "CXDMealDetailTableViewCell", bundle: Bundle.init(for: CXDMealDetailTableViewCell.self)), forCellReuseIdentifier: "CXDMealDetailTableViewCell")
        
        reviewsTableView.register(UINib.init(nibName: "CXDMealDetailHeaderTableViewCell", bundle: Bundle.init(for: CXDMealDetailHeaderTableViewCell.self)), forCellReuseIdentifier: "CXDMealDetailHeaderTableViewCell")
        
        let faveButton = FaveButton(
            frame: CGRect(x:0, y:0, width: 44, height: 44),
            faveIconNormal: UIImage(named: "Heart"))
        faveButton.delegate = self
        favButtonView.addSubview(faveButton)
        
        let resource = ImageResource(downloadURL: URL.init(string: (meal?.chefImageUrl)!)!)
        chefDescriptionImage.layer.cornerRadius = chefDescriptionImage.frame.size.width/2
        chefDescriptionImage.clipsToBounds = true
        chefDescriptionImage.kf.setImage(with: resource)

        chefDescriptionTitleLabel.text = (meal?.chefUsername)! + "'s Description"
        chefDescriptionLabel.text = meal?._description
        ingredientsLabel.text = meal?.ingredients
        ingredientsImage.layer.cornerRadius = ingredientsImage.frame.size.width/2
        ingredientsImage.clipsToBounds = true
        ingredientsImage.image = UIImage(named:"Ingredients")
        
        totalReviewsImageView.image = CXDUtility.sharedUtility.imageFor(rating: (meal?.rating?.intValue)!)
        totalReviewsLabel.text = (meal?.reviewCount?.stringValue)! + " reviews"
        
        preparationTimeView.layer.borderWidth = 2
        preparationTimeView.layer.borderColor = UIColor(red: 246/256, green: 102/256, blue: 71/256, alpha: 1).cgColor
        
        totalCostView.layer.borderWidth = 2
        totalCostView.layer.borderColor = UIColor(red: 246/256, green: 102/256, blue: 71/256, alpha: 1).cgColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        HUD.flash(.progress, onView: self.reviewsTableView)
        CXDApiServiceController.awsGetFromEndPoint(urlString: "/meals/1/reviews", queryParametersDict: ["page" : 0], pathParametersDict: nil, classType: CXDMealReview.self).continueWith { (task) -> Any? in
            DispatchQueue.main.async {
                HUD.hide()
                self.userReviews = task.result as! Array<CXDMealReview>
                self.reviewsTableView.reloadData()
                self.reviewsTableView.layoutIfNeeded()
                self.tableViewHeightConstraint.constant = self.reviewsTableView.contentSize.height + 10
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
        
        var cxdCartItem = CXDCartItem()
        cxdCartItem?.mealId = self.meal?.id
        cxdCartItem?.quantity = 1
        //cxdCartItem?.mealName = self.meal?.name
        //cxdCartItem?.chefName = self.meal?.chefUsername
        //cxdCartItem?.price = NSNumber(value: 10)
        cxdCartItem?.size = "Large"
        //cxdCartItem?.id = 41
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-DD-YYYY hh.mm.ss"
        cxdCartItem?.timeCreated = dateFormatter.string(from: Date())
        
        HUD.show(.progress, onView: self.navigationController?.view)
        CXDApiServiceController.awsPostForEndPoint(urlString: "/users/41/cart", queryParametersDict: nil, pathParametersDict: ["user_id":41], body: cxdCartItem!, classType: CXDCartItem.self).continueWith { (result) -> Any? in
            DispatchQueue.main.async {
                HUD.hide()
               if let cartButton = self.cartRightBarButton() as? BadgeBarButtonItem
               {
                    cartButton.badgeLabel.isHidden = false
                    cartButton.badgeText = "1"
                }
                
                if let error = result.error {
                    let alert = UIAlertController(title: "Attention", message: "Error occured while adding item to cart", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let PopupVC = self.setPopupVC(storyboradID:"Main",viewControllerID:"ReceipeAddedToCartViewController") as? ReceipeAddedToCartViewController
                    PopupVC?.popupCustomAlign = CGPoint(x: 50, y: 25)
                    PopupVC?.popupAnimation = .normal
                    PopupVC?.popupSize = CGSize(width: 300, height: 450)
                    PopupVC?.checkOutCompletionHandler = {
                        self.dismissPopup(completion: nil)
                        HUD.show(.progress, onView: self.navigationController?.view)
                        CXDApiServiceController.awsGetFromEndPoint(urlString: "/users/41/cart", queryParametersDict:nil, pathParametersDict:nil, classType: CXDCart.self).continueWith { (task) -> Any? in
                            
                            DispatchQueue.main.async {
                                HUD.hide()
                                self.showResult(task: task )
                            }
                        }
                    }
                    
                    self.presentPopup(controller: PopupVC!, completion: nil)
                }
            }
        }
    }
    
    @objc func checkOutButtonTapped()
    {
       
    }
    
    func showResult(task: AWSTask<AnyObject>) {
        if let error = task.error {
            print("Error: \(error)")
        } else if let result = task.result{
            
            let res = result as! CXDCart
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.init(for: CartViewController.self))
            let cartViewController = storyboard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
            cartViewController.cart = res
            
            self.navigationController!.pushViewController(cartViewController, animated: true)
        }
    }

    
    func faveButton(_ faveButton: FaveButton, didSelected selected: Bool) {
        
    }
}
