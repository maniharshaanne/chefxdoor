//
//  CXDAppMenuItem.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 9/28/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation

class CXDAppMenuItem {
    
  public enum MenuType {
        case ExploreFood
        case MyFavourites
        case OrderHistory
        case PaymentMethods
        case Search
        case Help
        case SwitchUser
        case Logout
        case Menu
        case Orders
        case PaymentInfo
    }
    
    public var title:String?
    public var imageName:String?
    public var menuType:MenuType?
    
    init(title:String, imageName:String, menuType:MenuType)
    {
        self.title = title
        self.imageName = imageName
        self.menuType = menuType
    }
}
