//
//  CXDMealDetailTableViewCell.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 9/22/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class CXDMealDetailTableViewCell: UITableViewCell {
    @IBOutlet public weak var profileImageView:UIImageView!
    @IBOutlet public weak var ratingImageView:UIImageView!
    @IBOutlet public weak var titleLabel:UILabel!
    @IBOutlet public weak var detailLabel:UILabel!

    public func updateCell(mealReview : CXDMealReview)
    {
        profileImageView.kf.cancelDownloadTask()
        
        if let imageUrl = mealReview.userPhotoUrl
        {
            let resource = ImageResource(downloadURL: URL.init(string: imageUrl)!)
            profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
            profileImageView.clipsToBounds = true
            profileImageView.kf.setImage(with: resource)
        }
        
        if let modifiedDate = mealReview.timeModified
        {
            var dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            var modifiedDateSplitString = modifiedDate.split(separator: "T").first!
            var modifiedSplitDate = dateFormatter.date(from: String(modifiedDateSplitString))
            dateFormatter.dateFormat = "MM/dd/yy"
            var modifiedDateString = dateFormatter.string(from: modifiedSplitDate!)
            titleLabel.text = mealReview.username! + " . " + modifiedDateString
        }

        detailLabel.text = mealReview.message
    }
}
