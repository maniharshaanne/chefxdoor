//
//  ReceipeAddedToCartViewController.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 9/25/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import UIKit
import MIBlurPopup

public class ReceipeAddedToCartViewController: UIViewController {
    @IBOutlet weak var findMoreButton:UIButton!
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var imageView:UIImageView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ReceipeAddedToCartViewController: MIBlurPopupDelegate {
    
    public var popupView: UIView {
        return self.view
    }
    
    public var blurEffectStyle: UIBlurEffectStyle {
        return UIBlurEffectStyle.light
    }
    
    public var initialScaleAmmount: CGFloat {
        return 1.0
    }
    
    public var animationDuration: TimeInterval {
        return 1.0
    }
    
}
