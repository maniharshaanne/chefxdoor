//
//  CXDChefMenuTableViewCell.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 2/8/19.
//  Copyright © 2019 ChefXDoor. All rights reserved.
//

import Foundation
import Kingfisher

class CXDChefMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var sellButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    public func updateInfo(meal:CXDMeal)
    {
        mealImageView.kf.cancelDownloadTask()
        mealImageView.image = UIImage(named: "Food_bg_placeholder.png")
        
        titleLabel.text = meal.name
        priceLabel.text = "$" + (meal.price?.stringValue)!
        descriptionLabel.text = meal._description
        countLabel.text = "qty: 5"
        ratingImageView.image = CXDUtility.sharedUtility.imageFor(rating: meal.rating?.intValue ?? 0)
        
        if let imageUrl = meal.imageUrl
        {
            let resource = ImageResource(downloadURL: URL.init(string: imageUrl)!, cacheKey: (meal.id?.stringValue)!+"bg")
            mealImageView.kf.setImage(with: resource)
        }
    }
    
}
