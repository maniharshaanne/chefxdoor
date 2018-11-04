//
//  CXDUserProfileViewController.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 11/2/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import PKHUD
import AWSCognito

class CXDUserProfileViewController: UIViewController {
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var streetAddress1Label: UILabel!
    @IBOutlet weak var streetAddress2Label: UILabel!
    @IBOutlet weak var cityZipcodeLabel: UILabel!
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    
    @IBOutlet weak var foodRestrictionsView: UIView!
    @IBOutlet weak var foodRestrictionsButton1: UIButton!
    @IBOutlet weak var foodRestrictionsButton2: UIButton!
    @IBOutlet weak var foodRestrictionsButton3: UIButton!
    @IBOutlet weak var foodRestrictionsButton4: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var backGroundImageView: UIImageView!
    
    var currentUser: CXDCurrentUser?
    
    override func viewDidLoad() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.darkGray
        self.navigationItem.rightBarButtonItems = customRightBarButtonItems()
        self.navigationItem.leftBarButtonItem = menuLeftBarButton()
        
        nameView.layer.borderWidth = 2
        nameView.layer.borderColor = UIColor(red: 248/256, green: 101/256, blue: 64/256, alpha: 1).cgColor
        
        addressView.layer.borderWidth = 2
        addressView.layer.borderColor = UIColor(red: 248/256, green: 101/256, blue: 64/256, alpha: 1).cgColor
        addressView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(addressViewTapped)))
        
        phoneView.layer.borderWidth = 2
        phoneView.layer.borderColor = UIColor(red: 248/256, green: 101/256, blue: 64/256, alpha: 1).cgColor
        
        cardView.layer.borderWidth = 2
        cardView.layer.borderColor = UIColor(red: 248/256, green: 101/256, blue: 64/256, alpha: 1).cgColor
        cardView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(cardViewTapped)))
        
        foodRestrictionsView.layer.borderWidth = 2
        foodRestrictionsView.layer.borderColor = UIColor(red: 248/256, green: 101/256, blue: 64/256, alpha: 1).cgColor
        
        foodRestrictionsButton1.backgroundColor = UIColor(red: 248/256, green: 101/256, blue: 64/256, alpha: 1)
        foodRestrictionsButton1.layer.cornerRadius = 5
        foodRestrictionsButton1.tag = 0001
        
        foodRestrictionsButton2.backgroundColor = UIColor(red: 248/256, green: 101/256, blue: 64/256, alpha: 1)
        foodRestrictionsButton2.layer.cornerRadius = 5
        foodRestrictionsButton1.tag = 0002

        foodRestrictionsButton3.backgroundColor = UIColor(red: 248/256, green: 101/256, blue: 64/256, alpha: 1)
        foodRestrictionsButton3.layer.cornerRadius = 5
        foodRestrictionsButton1.tag = 0003

        foodRestrictionsButton4.backgroundColor = UIColor(red: 248/256, green: 101/256, blue: 64/256, alpha: 1)
        foodRestrictionsButton4.layer.cornerRadius = 5
        foodRestrictionsButton1.tag = 0004

        //Assign Data
        firstNameTextField.text = currentUser?.firstname
        lastNameTextField.text = currentUser?.lastname
        
        phoneNumberTextField.text = currentUser?.phone?.stringValue
        
        if let deliveryAddress:CXDDeliveryAddress = currentUser?.mainDeliveryAddress
        {
            streetAddress1Label.text = deliveryAddress.street
            streetAddress2Label.text = deliveryAddress.city
            
            if let state = deliveryAddress.state, let zipCode = deliveryAddress.zip?.stringValue
            {
                cityZipcodeLabel.text = state + " " + zipCode
            }
        }
       
        if let payment = currentUser?.mainPaymentMethod
        {
            if let firstName = payment.firstName, let lastName = payment.lastName, let cardNumber = payment.cardNumber
            {
                cardNameLabel.text = firstName + " " + lastName
                cardNumberLabel.text = cardNumber
            }
            
        }
        
        backGroundImageView.kf.cancelDownloadTask()
        if let backGroundIMageUrl = currentUser?.imageUrl
        {
            let resource = ImageResource(downloadURL: URL(string: backGroundIMageUrl)!)
            backGroundImageView.kf.setImage(with: resource)
        }
    }
    
    @objc func cardViewTapped() {
        HUD.flash(.progress, onView: self.navigationController?.view)
        CXDApiServiceController.awsGetFromEndPoint(urlString: "/users/currentuser/billing" , queryParametersDict: nil, pathParametersDict: nil, classType: CXDBilling.self).continueWith { (task) -> Any? in
            
            DispatchQueue.main.async {
                HUD.hide()
                
                if let error = task.error {
                    print ("error: \(error)")
                } else if let result = task.result {
                    let cardDetails = result as! [CXDBilling]
                    
                    let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.init(for: CXDUserProfileViewController.self))
                    let cardItemsViewController = storyBoard.instantiateViewController(withIdentifier: "CXDItemsTableViewController") as! CXDItemsTableViewController
                    cardItemsViewController.billingItems = cardDetails
                    cardItemsViewController.itemType = .cardType
                    self.navigationController!.pushViewController(cardItemsViewController, animated: true)
                }
            }
        }
    }
    
    @objc func addressViewTapped() {
        HUD.flash(.progress, onView: self.navigationController?.view)
        CXDApiServiceController.awsGetFromEndPoint(urlString: "/users/currentuser/delivery_address" , queryParametersDict: nil, pathParametersDict: nil, classType: CXDDeliveryAddress.self).continueWith { (task) -> Any? in
            
            DispatchQueue.main.async {
                HUD.hide()
                
                if let error = task.error {
                    print ("error: \(error)")
                } else if let result = task.result {
                    let addressItems = result as! [CXDDeliveryAddress]
                    
                    let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.init(for: CXDUserProfileViewController.self))
                    let cardItemsViewController = storyBoard.instantiateViewController(withIdentifier: "CXDItemsTableViewController") as! CXDItemsTableViewController
                    cardItemsViewController.addressItems = addressItems
                    cardItemsViewController.itemType = .addressType
                    self.navigationController!.pushViewController(cardItemsViewController, animated: true)
                }
            }
        }
    }
}
