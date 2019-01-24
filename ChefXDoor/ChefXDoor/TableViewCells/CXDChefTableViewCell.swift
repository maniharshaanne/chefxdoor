//
//  CXDChefTableViewCell.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 9/27/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class CXDChefTableViewCell:UITableViewCell {
  
    @IBOutlet weak var chefImageView:ImageView!
    @IBOutlet weak var chefNameLabel: UILabel!
    @IBOutlet weak var chefMenuItemsLabel: UILabel!
    @IBOutlet weak var chefTagLineLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var timeEstimateLabel:UILabel!
    
    public func updateInfo(chefInfo:CXDChef)
    {
        chefImageView.kf.cancelDownloadTask()
        
        if let imageUrl = chefInfo.imageUrl
        {
            let resource = ImageResource(downloadURL: URL.init(string: imageUrl)!)
            chefImageView.kf.setImage(with: resource)
        }
        
        chefNameLabel.text = chefInfo.username
        chefMenuItemsLabel.text = chefInfo.categories
        chefTagLineLabel.text = chefInfo.slogan
        
        let image = CXDUtility.sharedUtility.imageFor(rating: chefInfo.rating?.intValue ?? 0)
        ratingImageView.image = image.withRenderingMode(.alwaysTemplate)
        ratingImageView.tintColor = CXDAppearance.primaryColor()
        
        reviewsLabel.text = (chefInfo.reviewCount?.stringValue ?? "0")  + " reviews"
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.roundingMode = .up
        
        let str = String(describing: formatter.string(from: (chefInfo.distance ?? 0))!)
        timeEstimateLabel.text = str + " Miles"
    }
}
