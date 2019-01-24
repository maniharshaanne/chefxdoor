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
    public var checkOutCompletionHandler: (() -> Void)?

    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.borderColor = CXDAppearance.primaryColor().cgColor
        self.view.layer.borderWidth = 2
        self.imageView.image = self.imageView.image!.withRenderingMode(.alwaysTemplate)
        self.imageView.tintColor = CXDAppearance.primaryColor()
    }
    
    @IBAction func checkOutButtonTapped(_ sender: Any) {
        if let callback = self.checkOutCompletionHandler {
            callback ()
        }
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
