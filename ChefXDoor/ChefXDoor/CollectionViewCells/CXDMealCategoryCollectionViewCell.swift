//
//  CXDMealCategoryCollectionViewCell.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 9/16/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class CXDMealCategoryCollectionViewCell: UICollectionViewCell{
    
   @IBOutlet public weak var categoryImageView:UIImageView!
    @IBOutlet public weak var chefsCookingLabel:UILabel!
     @IBOutlet public weak var categoryNameLabel:UILabel!
    
    public func updateInfo(category:CXDMealCategory)
    {
        categoryImageView.kf.cancelDownloadTask()
        categoryImageView.image = UIImage(named:"CategoryPH.png")
        
        chefsCookingLabel.text = (category.count?.stringValue)! + " chefs cooking"
        categoryNameLabel.text = category.name
        
        if let imageUrl = category.imageUrl
        {
            let resource = ImageResource(downloadURL: URL.init(string: imageUrl)!)
            categoryImageView.kf.setImage(with: resource)
        }
    }
}
