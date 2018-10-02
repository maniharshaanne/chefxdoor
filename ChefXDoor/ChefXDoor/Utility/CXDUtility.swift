//
//  CXDUtility.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 9/30/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import UIKit

class CXDUtility{
    
    static var sharedUtility = CXDUtility()
    
    public func imageFor(rating : Int) -> UIImage
    {
        switch rating
        {
            case 1:
                return UIImage(named:"ic_1stars")!
            case 2:
                return UIImage(named:"ic_2stars")!
            case 3:
                return UIImage(named:"ic_3stars")!
            case 4:
                return UIImage(named:"ic_4stars")!
            case 5:
                return UIImage(named:"ic_5stars")!
            default:
                return UIImage(named:"ic_5stars")!
        }
    }
}
