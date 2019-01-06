//
//  CXDMealTableViewCell.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 9/13/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import FaveButton

class CXDMealTableViewCell: UITableViewCell,FaveButtonDelegate  {
    
   @IBOutlet public weak var backgroundImageView: UIImageView!
    @IBOutlet public weak var transparentView: UIView!
    @IBOutlet public weak var profileImageView: UIImageView!
    @IBOutlet public weak var mealNameLabel:UILabel!
    @IBOutlet public weak var chefNameLabel:UILabel!
    @IBOutlet public weak var pribeLabel:UILabel!
    @IBOutlet public weak var ratingImageView:UIImageView!
    @IBOutlet public weak var favButtonView:UIView!
    @IBOutlet public weak var profileImageViewWidthConstraint:NSLayoutConstraint!
    @IBOutlet public weak var ratingImageViewHeightConstraint:NSLayoutConstraint!

    var favouriteMealSelected : (() -> Void)?
    var favoriteMealUnSelected : (() -> Void)?
    var faveButton:FaveButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        faveButton = FaveButton(
            frame: CGRect(x:self.contentView.frame.size.width - 60, y:0, width: 44, height: 44),
            faveIconNormal: UIImage(named: "Heart")
        )
        
        faveButton?.delegate = self
        faveButton?.isSelected = false
        faveButton?.selectedColor = UIColor(red: 246/256, green: 102/256, blue: 71/256, alpha: 1)
        //faveButton?.normalColor = UIColor.white
        faveButton?.tintColor = UIColor.white

        backgroundImageView.isUserInteractionEnabled = true
        backgroundImageView.addSubview(faveButton!)
        
        transparentView.backgroundColor = UIColor(red: 98/256, green: 98/256, blue: 98/256, alpha: 0.5)
    }
    
    public func updateInfo(order:CXDOrder)
    {
        backgroundImageView.kf.cancelDownloadTask()
        backgroundImageView.image = UIImage(named: "Food_bg_placeholder.png")
        
        profileImageViewWidthConstraint.priority = UILayoutPriority(rawValue: 999)
        
        mealNameLabel.text = "Order # " + (order.orderNumber?.stringValue)!
        
        if let imageUrl = order.mainPhoto
        {
            let resource = ImageResource(downloadURL: URL.init(string: imageUrl)!)
            backgroundImageView.kf.setImage(with: resource)
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let createdDate = dateFormatter.date(from: order.timeCreated!)
        dateFormatter.dateFormat = "MMM dd, yyyy, h:mm aa"
        let createdDateString = dateFormatter.string(from: createdDate!)
        
        chefNameLabel.text = createdDateString
        pribeLabel.text = "$" + (order.deliveryFee?.stringValue)!
        profileImageViewWidthConstraint.constant = 0
        ratingImageViewHeightConstraint.constant = 0
    }
    
    public func updateInfo(meal:CXDMeal)
    {
        profileImageViewWidthConstraint.constant = 40
        ratingImageViewHeightConstraint.constant = 10
        
        backgroundImageView.kf.cancelDownloadTask()
        backgroundImageView.image = UIImage(named: "Food_bg_placeholder.png")
        
        profileImageView.kf.cancelDownloadTask()
        profileImageView.image = UIImage(named: "avatar.png")
        
        mealNameLabel.text = meal.name
        chefNameLabel.text = meal.chefUsername
        pribeLabel.text = "$" + (meal.price?.stringValue)!
        
        if let imageUrl = meal.imageUrl
        {
            let resource = ImageResource(downloadURL: URL.init(string: imageUrl)!, cacheKey: (meal.id?.stringValue)!+"bg")
            backgroundImageView.kf.setImage(with: resource)
        }
        
        if let chefImageUrl = meal.chefImageUrl
        {
            profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
            profileImageView.clipsToBounds = true
            let resource = ImageResource(downloadURL: URL.init(string: chefImageUrl)!, cacheKey: (meal.id?.stringValue)!)
            profileImageView.kf.setImage(with: resource)
        }

        if let isLiked = meal.liked?.boolValue
        {
            faveButton?.setSelected(selected: isLiked , animated: false)
        }
    }
    
    func faveButton(_ faveButton: FaveButton, didSelected selected: Bool)
    {
        if selected
        {
           if  favouriteMealSelected != nil
           {
            favouriteMealSelected!()
           }
        }
        else
        {
            if  favoriteMealUnSelected != nil
            {
                favoriteMealUnSelected!()
            }
        }
    }
}
