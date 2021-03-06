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
import Fusuma
import AWSS3

class CXDUserProfileViewController: UIViewController, FusumaDelegate, UITextFieldDelegate {
    
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
    
    var currentLoggedUser: CXDCurrentUser?
    var foodRestrctions: [CXDFoodRestriction]?
    var contentUrl: String?
    
    override func viewDidLoad() {
        
        self.navigationController?.navigationBar.barTintColor = CXDAppearance.primaryBackgroundDarkColor()
        self.navigationItem.rightBarButtonItems = customRightBarButtonItems()
        self.navigationItem.leftBarButtonItem = menuLeftBarButton()
        
        nameView.layer.borderWidth = 2
        nameView.layer.borderColor = CXDAppearance.primaryColor().cgColor
        
        addressView.layer.borderWidth = 2
        addressView.layer.borderColor = CXDAppearance.primaryColor().cgColor
        addressView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(addressViewTapped)))
        
        phoneView.layer.borderWidth = 2
        phoneView.layer.borderColor = CXDAppearance.primaryColor().cgColor
        
        cardView.layer.borderWidth = 2
        cardView.layer.borderColor = CXDAppearance.primaryColor().cgColor
        cardView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(cardViewTapped)))
        
        foodRestrictionsView.layer.borderWidth = 2
        foodRestrictionsView.layer.borderColor = CXDAppearance.primaryColor().cgColor
        
        //foodRestrictionsButton1.backgroundColor = UIColor(red: 248/256, green: 101/256, blue: 64/256, alpha: 1)
        foodRestrictionsButton1.layer.cornerRadius = 5
        foodRestrictionsButton1.layer.borderColor = CXDAppearance.primaryColor().cgColor
        foodRestrictionsButton1.layer.borderWidth = 2
        foodRestrictionsButton1.tag = 0001
        foodRestrictionsButton1.setTitle("Vegetarian", for: UIControlState.normal)

        //foodRestrictionsButton2.backgroundColor = UIColor(red: 248/256, green: 101/256, blue: 64/256, alpha: 1)
        foodRestrictionsButton2.layer.cornerRadius = 5
        foodRestrictionsButton2.layer.borderColor = CXDAppearance.primaryColor().cgColor
        foodRestrictionsButton2.layer.borderWidth = 2
        foodRestrictionsButton2.tag = 0002
        foodRestrictionsButton2.setTitle("Halal", for: UIControlState.normal)

        //foodRestrictionsButton3.backgroundColor = UIColor(red: 248/256, green: 101/256, blue: 64/256, alpha: 1)
        foodRestrictionsButton3.layer.cornerRadius = 5
        foodRestrictionsButton3.layer.borderColor = CXDAppearance.primaryColor().cgColor
        foodRestrictionsButton3.layer.borderWidth = 2
        foodRestrictionsButton3.tag = 0003
        foodRestrictionsButton2.setTitle("Vegan", for: UIControlState.normal)

        //foodRestrictionsButton4.backgroundColor = UIColor(red: 248/256, green: 101/256, blue: 64/256, alpha: 1)
        foodRestrictionsButton4.layer.cornerRadius = 5
        foodRestrictionsButton4.layer.borderColor = CXDAppearance.primaryColor().cgColor
        foodRestrictionsButton4.layer.borderWidth = 2
        foodRestrictionsButton4.tag = 0004
        foodRestrictionsButton4.setTitle("Kosher", for: UIControlState.normal)
        
        //Assign Data
        firstNameTextField.text = currentLoggedUser?.firstname
        firstNameTextField.delegate = self
        
        lastNameTextField.text = currentLoggedUser?.lastname
        lastNameTextField.delegate = self
        
        phoneNumberTextField.text = currentLoggedUser?.phone?.stringValue
        //phoneNumberTextField.text = currentLoggedUser?.phone
        phoneNumberTextField.delegate = self
        
        if let deliveryAddress:CXDDeliveryAddress = currentLoggedUser?.mainDeliveryAddress
        {
            streetAddress1Label.text = deliveryAddress.street
            streetAddress2Label.text = deliveryAddress.city
            
            if let state = deliveryAddress.state, let zipCode = deliveryAddress.zip?.stringValue
            {
                cityZipcodeLabel.text = state + " " + zipCode
            }
        }
       
        if let payment = currentLoggedUser?.mainPaymentMethod
        {
            if let firstName = payment.firstName, let lastName = payment.lastName, let cardNumber = payment.cardNumber
            {
                cardNameLabel.text = firstName + " " + lastName
                cardNumberLabel.text = cardNumber
            }
            
        }
        
        backGroundImageView.kf.cancelDownloadTask()
        if let backGroundIMageUrl = currentLoggedUser?.imageUrl
        {
            let resource = ImageResource(downloadURL: URL(string: backGroundIMageUrl)!)
            backGroundImageView.kf.setImage(with: resource)
        }
        
        self.backGroundImageView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(photoTapped)))
        backGroundImageView.isUserInteractionEnabled = true
        
       if let foodRest = currentLoggedUser?.foodRestrictions
       {
         foodRestrctions = currentLoggedUser?.foodRestrictions
         for foodRestriction:CXDFoodRestriction in foodRest
         {
            if let name = foodRestriction.name
            {
                updateFoodRestrictionButton(restriction: name)
            }
         }
       }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        HUD.show(.progress, onView: self.view)
        CXDApiServiceController.awsGetFromEndPoint(urlString: "/users/currentuser", queryParametersDict: nil, pathParametersDict: nil, classType: CXDCurrentUser.self).continueWith { (task) -> Any? in
            
            DispatchQueue.main.async {
                HUD.hide()
                if let error = task.error {
                    print("error : \(error)")
                } else if let result = task.result {
                    self.currentLoggedUser = result as! CXDCurrentUser
                    
                    //Assign Data
                    self.firstNameTextField.text = self.currentLoggedUser?.firstname
                    self.firstNameTextField.delegate = self
                    
                    self.lastNameTextField.text = self.currentLoggedUser?.lastname
                    self.lastNameTextField.delegate = self
                    
                    self.phoneNumberTextField.text = self.currentLoggedUser?.phone?.stringValue
                    //phoneNumberTextField.text = currentLoggedUser?.phone
                    self.phoneNumberTextField.delegate = self
                    
                    if let deliveryAddress:CXDDeliveryAddress = self.currentLoggedUser?.mainDeliveryAddress
                    {
                        self.streetAddress1Label.text = deliveryAddress.street
                        self.streetAddress2Label.text = deliveryAddress.city
                        
                        if let state = deliveryAddress.state, let zipCode = deliveryAddress.zip?.stringValue
                        {
                            self.cityZipcodeLabel.text = state + " " + zipCode
                        }
                    }
                    
                    if let payment = self.currentLoggedUser?.mainPaymentMethod
                    {
                        if let firstName = payment.firstName, let lastName = payment.lastName, let cardNumber = payment.cardNumber
                        {
                            self.cardNameLabel.text = firstName + " " + lastName
                            self.cardNumberLabel.text = cardNumber
                        }
                        
                    }
                    
                    self.backGroundImageView.kf.cancelDownloadTask()
                    if let backGroundIMageUrl = self.currentLoggedUser?.imageUrl
                    {
                        let resource = ImageResource(downloadURL: URL(string: backGroundIMageUrl)!)
                        self.backGroundImageView.kf.setImage(with: resource)
                    }
                    
                    self.backGroundImageView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.photoTapped)))
                    self.backGroundImageView.isUserInteractionEnabled = true
                    
                    if let foodRest = self.currentLoggedUser?.foodRestrictions
                    {
                        self.foodRestrctions = self.currentLoggedUser?.foodRestrictions
                        for foodRestriction:CXDFoodRestriction in foodRest
                        {
                            if let name = foodRestriction.name
                            {
                                self.updateFoodRestrictionButton(restriction: name)
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("view did appear called")
    }
    
    func refreshUserInfo() {
        
    }
    
    @objc func photoTapped() {
        // Show Fusuma
        let fusuma = FusumaViewController()
        
        fusuma.delegate = self
        fusuma.cropHeightRatio = 1.0
        fusuma.allowMultipleSelection = false
        fusumaSavesImage = true
        
        self.present(fusuma, animated: true, completion: nil)
    }
    
    // MARK: FusumaDelegate Protocol
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
        
        switch source {
            
        case .camera:
            
            print("Image captured from Camera")
            
        case .library:
            
            print("Image selected from Camera Roll")
            
        default:
            
            print("Image selected")
        }
        
        self.backGroundImageView.image = image
    }
    
    func fusumaMultipleImageSelected(_ images: [UIImage], source: FusumaMode) {
        
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: URL) {
        
    }
    
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode, metaData: ImageMetadata) {
        
        print("Image mediatype: \(metaData.mediaType)")
        print("Source image size: \(metaData.pixelWidth)x\(metaData.pixelHeight)")
        print("Creation date: \(String(describing: metaData.creationDate))")
        print("Modification date: \(String(describing: metaData.modificationDate))")
        print("Video duration: \(metaData.duration)")
        print("Is favourite: \(metaData.isFavourite)")
        print("Is hidden: \(metaData.isHidden)")
        print("Location: \(String(describing: metaData.location))")
    }
    
    func fusumaDismissedWithImage(_ image: UIImage, source: FusumaMode) {
        uploadImage(image: image)
        switch source {
            
        case .camera:
            
            print("Called just after dismissed FusumaViewController using Camera")
            
        case .library:
            
            print("Called just after dismissed FusumaViewController using Camera Roll")
            
        default:
            
            print("Called just after dismissed FusumaViewController")
        }
    }
    
    func fusumaCameraRollUnauthorized() {
        
        print("Camera roll unauthorized")
        
        let alert = UIAlertController(title: "Access Requested",
                                      message: "Saving image needs to access your photo album",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Settings", style: .default) { (action) -> Void in
            
            if let url = URL(string:UIApplicationOpenSettingsURLString) {
                
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            
        })
        
        guard let vc = UIApplication.shared.delegate?.window??.rootViewController,
            let presented = vc.presentedViewController else {
                
                return
        }
        
        presented.present(alert, animated: true, completion: nil)
    }
    
    func fusumaClosed() {
        
        print("Called when the FusumaViewController disappeared")
    }
    
    func fusumaWillClosed() {
        
        print("Called when the close button is pressed")
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
    
    func updateFoodRestrictionButton(restriction : String)
    {
        switch restriction {
        case "Vegetarian":
                foodRestrictionsButton4.backgroundColor = CXDAppearance.primaryColor()
            break
        case "Halal":
            foodRestrictionsButton4.backgroundColor = CXDAppearance.primaryColor()
            break
        case "Vegan":
            foodRestrictionsButton4.backgroundColor = CXDAppearance.primaryColor()
            break
        case "Kosher":
            foodRestrictionsButton4.backgroundColor = CXDAppearance.primaryColor()
            break
        default:
            break
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == firstNameTextField {
            if let firstName = textField.text, !firstName.isEmpty {
                currentLoggedUser?.firstname = firstName
            }
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        HUD.show(.progress, onView: self.navigationController?.view)
        CXDApiServiceController.awsPutForEndPoint(urlString: "/users/currentuser", queryParametersDict: nil, pathParametersDict: nil, body: currentLoggedUser!, classType: CXDCurrentUser.self).continueWith { (task) -> Any? in
            DispatchQueue.main.async {
                HUD.hide()
                
                if let error = task.error {
                    print ("error: \(error)")
                }
            }
        }
    }
    
    //Save Image Temporarily
    func storeImageToDocumentDirectory(image: UIImage, fileName: String) -> URL? {
        guard let data = UIImageJPEGRepresentation(image, 0.5) else {
            return nil
        }
        let fileURL = self.fileURLInDocumentDirectory(fileName)
        do {
            try data.write(to: fileURL)
            return fileURL
        } catch {
            return nil
        }
    }
    
    var documentsDirectoryURL: URL {
        return FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)[0]
    }
    
    func fileURLInDocumentDirectory(_ fileName: String) -> URL {
        return self.documentsDirectoryURL.appendingPathComponent(fileName)
    }
    
    //Uploading Pic
    func uploadImage(image: UIImage) {
        //Save image temp
        //Get the loc
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd_HHmmss"
        let fileName = dateFormatter.string(from: Date())
        let fileNameWithExtension = "\(fileName)" + ".jpg"
        
        if let localImageUrl = storeImageToDocumentDirectory(image: image, fileName: fileNameWithExtension)
        {
            let key = "user_images/img" + "\(fileNameWithExtension)"

            let request = AWSS3TransferManagerUploadRequest()!
            request.bucket = "cxd-media-bucket"
            request.key = key
            request.body = localImageUrl
            request.acl = .publicRead
            
            let transferManager = AWSS3TransferManager.default()
            transferManager.upload(request).continueWith(executor: AWSExecutor.mainThread()) { (task) -> Any? in
                if let error = task.error {
                    print(error)
                }
                if task.result != nil {
                    print("Uploaded \(key)")
                    let imageUrl = "https://cxd-media-bucket" + ".s3.amazonaws.com/" + "\(key)"
                    self.postImageUrl(imageUrl: imageUrl)
                }
                
                return nil
            }
        }
        
    }
    
    func postImageUrl(imageUrl: String) {
        
        let userPhoto:CXDUserPhoto = CXDUserPhoto()
        userPhoto.imageUrl = imageUrl
        userPhoto.isMainPhoto = NSNumber.init(booleanLiteral: true)
        
        if let photoId = currentLoggedUser?.imageId, photoId.intValue != 0 {
            CXDApiServiceController.awsPutForEndPoint(urlString: "/users/currentuser/photos/\(photoId)", queryParametersDict: nil, pathParametersDict: ["photo_id" : photoId.stringValue], body: userPhoto, classType: CXDUserPhoto.self).continueWith(executor: AWSExecutor.mainThread()) { (task) -> Any? in
                if let error = task.error {
                    print(error)
                }
                if task.result != nil {
                    print("Uploaded Successfully")
                }
                
                return nil
            }
            
        } else {
            //POST
//            var userPhotoArray:CXDArrayOfUserPhoto = CXDArrayOfUserPhoto()
//            userPhotoArray = [userPhoto]
//
//            CXDApiServiceController.awsPostForEndPoint(urlString: "/users/currentuser/photos", queryParametersDict: nil, pathParametersDict: nil, body: userPhotoArray, classType: CXDArrayOfUserPhoto.self)
        }
    }
}
