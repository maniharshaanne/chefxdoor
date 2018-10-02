//
//  PaymentViewController.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 9/30/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import UIKit

class PaymentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addNewPaymentButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.init(for: AddNewPaymentViewController.self))
        let addNewPaymentViewController = storyboard.instantiateViewController(withIdentifier: "AddNewPaymentViewController") as! AddNewPaymentViewController
        self.navigationController!.pushViewController(addNewPaymentViewController, animated: true)
    }
}
