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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let faveButton = FaveButton(
            frame: CGRect(x:backgroundImageView.frame.size.width - 44, y:0, width: 44, height: 44),
            faveIconNormal: UIImage(named: "Heart")
        )
        faveButton.delegate = self
        backgroundImageView.isUserInteractionEnabled = true
        backgroundImageView.addSubview(faveButton)
    }
    
    public func updateInfo(meal:CXDMeal)
    {
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

    }
    
    func faveButton(_ faveButton: FaveButton, didSelected selected: Bool) {
    }
}
