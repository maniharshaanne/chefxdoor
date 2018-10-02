//
//  UIViewController+NavBar.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 9/29/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func menuLeftBarButton() -> UIBarButtonItem{
        let menuLeftBarButton:UIBarButtonItem = UIBarButtonItem(image: UIImage(named:"Hamburger"), style: .plain, target: self, action:#selector(menuButtonTapped(sender:)))
        menuLeftBarButton.tintColor = UIColor.white
        
        return menuLeftBarButton
    }
    
    func searchRightBarButton() -> UIBarButtonItem {
        let searchRightBarButton:UIBarButtonItem = UIBarButtonItem(image: UIImage(named:"SearchWhiteChefxdoor"), style: .plain, target: self, action:#selector(searchRightBarButtonTapped(sender:)))
        searchRightBarButton.tintColor = UIColor.white
        
        return searchRightBarButton
    }
    
    func cartRightBarButton() -> UIBarButtonItem {
        let cartRightBarButton:UIBarButtonItem = UIBarButtonItem(image: UIImage(named:"Cart"), style: .plain, target: self, action:#selector(cartRightBarButtonTapped(sender:)))
        cartRightBarButton.tintColor = UIColor.white
        
        return cartRightBarButton
    }
    
    func customRightBarButtonItems() -> Array<UIBarButtonItem>{
        return [searchRightBarButton() , cartRightBarButton()]
    }
    
    @objc func menuButtonTapped(sender: UIBarButtonItem) {
        panel?.openLeft(animated: true)
    }
    
    @objc func searchRightBarButtonTapped(sender: UIBarButtonItem) {
        panel?.openLeft(animated: true)
    }
    
    @objc func cartRightBarButtonTapped(sender: UIBarButtonItem){
        panel?.openLeft(animated: true)
    }
}
