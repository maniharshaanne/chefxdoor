//
//  CXDAddNewAddressViewController.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 1/13/19.
//  Copyright © 2019 ChefXDoor. All rights reserved.
//

import UIKit
import GooglePlaces
import PKHUD

class CXDAddNewAddressViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipcodeTextField: UITextField!
    @IBOutlet weak var unitNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let increasedAlpha: CGFloat = UIColor.white.cgColor.alpha * 0.6
        let placeHolderColor: UIColor = UIColor.white.withAlphaComponent(increasedAlpha)
        
        let placeholderAttributes: [NSAttributedStringKey : Any] = [
            NSAttributedString.Key.foregroundColor: placeHolderColor,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: UIFont.systemFontSize)
        ]
        
        addressTextField.delegate = self
        addressTextField.attributedPlaceholder = NSAttributedString(string: "Add Address ", attributes: placeholderAttributes)
        addressTextField.textColor = UIColor.white
        
        cityTextField.attributedPlaceholder = NSAttributedString(string: "City", attributes: placeholderAttributes)
        cityTextField.textColor = UIColor.white
        
        stateTextField.attributedPlaceholder = NSAttributedString(string: "State", attributes: placeholderAttributes)
        stateTextField.textColor = UIColor.white
        
        zipcodeTextField.attributedPlaceholder = NSAttributedString(string: "Zipcode", attributes: placeholderAttributes)
        zipcodeTextField.textColor = UIColor.white
        
        unitNumberTextField.attributedPlaceholder = NSAttributedString(string: "Apt# or Company Name", attributes: placeholderAttributes)
        unitNumberTextField.textColor = UIColor.white
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == addressTextField
        {
            openBlackTheme()
        }
    }
    
    func openBlackTheme() {
        let backgroundColor = UIColor(white: 0.25, alpha: 1.0)
        let selectedTableCellBackgroundColor = UIColor(white: 0.35, alpha: 1.0)
        let darkBackgroundColor = UIColor(white: 0.2, alpha: 1.0)
        let primaryTextColor = UIColor.white
        let highlightColor = CXDAppearance.primaryColor()
        let secondaryColor = UIColor(white: 1.0, alpha: 0.5)
        let tintColor = UIColor.white
        let searchBarTintColor: UIColor = tintColor
        let separatorColor = UIColor(red: 0.5, green: 0.75, blue: 0.5, alpha: 0.30)
        
        presentAutocompleteController(withBackgroundColor: backgroundColor, selectedTableCellBackgroundColor: selectedTableCellBackgroundColor, darkBackgroundColor: darkBackgroundColor, primaryTextColor: primaryTextColor, highlight: highlightColor, secondaryColor: secondaryColor, tintColor: tintColor, searchBarTintColor: searchBarTintColor, separatorColor: separatorColor)
    }
    
    func presentAutocompleteController(withBackgroundColor backgroundColor: UIColor?, selectedTableCellBackgroundColor: UIColor?, darkBackgroundColor: UIColor?, primaryTextColor: UIColor?, highlight highlightColor: UIColor?, secondaryColor: UIColor?, tintColor: UIColor?, searchBarTintColor: UIColor?, separatorColor: UIColor?) {
        // Use UIAppearance proxies to change the appearance of UI controls in
        // GMSAutocompleteViewController. Here we use appearanceWhenContainedIn to localise changes to
        // just this part of the Demo app. This will generally not be necessary in a real application as
        // you will probably want the same theme to apply to all elements in your app.
        let appearence = UIActivityIndicatorView.appearance(whenContainedInInstancesOf: [GMSAutocompleteViewController.self])
        if let primaryTextColor = primaryTextColor {
            appearence.color = primaryTextColor
        }
        
        UINavigationBar.appearance(whenContainedInInstancesOf: [GMSAutocompleteViewController.self]).barTintColor = darkBackgroundColor
        if let searchBarTintColor = searchBarTintColor {
            UINavigationBar.appearance(whenContainedInInstancesOf: [GMSAutocompleteViewController.self]).tintColor = searchBarTintColor
        }
        
        // Color of typed text in search bar.
        var searchBarTextAttributes: [String : Any]? = nil
        if let searchBarTintColor = searchBarTintColor {
            searchBarTextAttributes = [
                NSAttributedString.Key.foregroundColor.rawValue : searchBarTintColor,
                NSAttributedString.Key.font.rawValue : UIFont.systemFont(ofSize: UIFont.systemFontSize)
            ]
        }
        
        if let searchBarTextAttributes = searchBarTextAttributes {
            UITextField.appearance(whenContainedInInstancesOf: [GMSAutocompleteViewController.self]).defaultTextAttributes = searchBarTextAttributes
        }
        
        // Color of the "Search" placeholder text in search bar. For this example, we'll make it the same
        // as the bar tint color but with added transparency.
        let increasedAlpha: CGFloat = searchBarTintColor!.cgColor.alpha * 0.75
        let placeHolderColor: UIColor? = searchBarTintColor?.withAlphaComponent(increasedAlpha)
        
        var placeholderAttributes: [NSAttributedStringKey : Any]? = nil
        if let placeHolderColor = placeHolderColor {
            placeholderAttributes = [
                NSAttributedString.Key.foregroundColor: placeHolderColor,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: UIFont.systemFontSize)
            ]
        }
        let attributedPlaceholder = NSAttributedString(string: "Search Address ", attributes: placeholderAttributes)
        
        UITextField.appearance(whenContainedInInstancesOf: [GMSAutocompleteViewController.self]).attributedPlaceholder = attributedPlaceholder
        
        // Change the background color of selected table cells.
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = selectedTableCellBackgroundColor
        let tableCellAppearance = UITableViewCell.appearance(whenContainedInInstancesOf: [GMSAutocompleteViewController.self])
        tableCellAppearance.selectedBackgroundView = selectedBackgroundView
        
        // Depending on the navigation bar background color, it might also be necessary to customise the
        // icons displayed in the search bar to something other than the default. The
        // setupSearchBarCustomIcons method contains example code to do this.
        
        let placePickerController = GMSAutocompleteViewController()
        placePickerController.delegate = self
        placePickerController.tableCellBackgroundColor = backgroundColor!
        placePickerController.tableCellSeparatorColor = separatorColor!
        placePickerController.primaryTextColor = primaryTextColor!
        placePickerController.primaryTextHighlightColor = highlightColor!
        placePickerController.secondaryTextColor = secondaryColor!
        placePickerController.tintColor = tintColor

        present(placePickerController, animated: true)
    }
    
    @IBAction func saveAddress(_ sender: Any) {
        HUD.show(.progress)
        
        let deliveryAddress = CXDDeliveryAddress()
        deliveryAddress?.street = addressTextField.text
        deliveryAddress?.city = cityTextField.text
        deliveryAddress?.state = stateTextField.text
        deliveryAddress?.zip = NSNumber(integerLiteral: Int(zipcodeTextField.text ?? "0") ?? 0)
        deliveryAddress?.isMainAddress = NSNumber(integerLiteral: 1)
        
        if let deliveryAddress = deliveryAddress
        {
            CXDApiServiceController.awsPostForEndPoint(urlString: "/users/currentuser/delivery_address", queryParametersDict: nil, pathParametersDict: ["user_id" : "41"], body: deliveryAddress, classType: CXDDeliveryAddress.self).continueWith { (task) -> Any? in
                DispatchQueue.main.async {
                    HUD.hide()
                    
                    if let error = task.error {
                        print(error)
                    }
                    else
                    {
                        let controllers = self.navigationController?.viewControllers
                        for vc in controllers! {
                            if vc is CXDUserProfileViewController {
                                _ = self.navigationController?.popToViewController(vc as! CXDUserProfileViewController, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
}

extension CXDAddNewAddressViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        
        var keys = [String]()
        place.addressComponents?.forEach{keys.append($0.type)}
        var keyValuePair = [String : String]()
        place.addressComponents?.forEach({ (component) in
            keys.forEach{ component.type == $0 ? keyValuePair[$0] = component.name : nil}
        })
        
        let stateDictionary: [String : String] = [ "Alaska" : "AK", "Alabama" : "AL", "Arkansas" : "AR", "American Samoa" : "AS", "Arizona" : "AZ", "California" : "CA", "Colorado" : "CO", "Connecticut" : "CT", "District of Columbia" : "DC", "Delaware" : "DE", "Florida" : "FL", "Georgia" : "GA", "Guam" : "GU", "Hawaii" : "HI", "Iowa" : "IA", "Idaho" : "ID", "Illinois" : "IL", "Indiana" : "IN", "Kansas" : "KS", "Kentucky" : "KY", "Louisiana" : "LA", "Massachusetts" : "MA", "Maryland" : "MD", "Maine" : "ME", "Michigan" : "MI", "Minnesota" : "MN", "Missouri" : "MO", "Mississippi" : "MS", "Montana" : "MT", "North Carolina" : "NC", "North Dakota" : "ND", "Nebraska" : "NE", "New Hampshire" : "NH", "New Jersey" : "NJ", "New Mexico" : "NM", "Nevada" : "NV", "New York" : "NY", "Ohio" : "OH", "Oklahoma" : "OK", "Oregon" : "OR", "Pennsylvania" : "PA", "Puerto Rico" : "PR", "Rhode Island" : "RI", "South Carolina" : "SC", "South Dakota" : "SD", "Tennessee" : "TN", "Texas" : "TX", "Utah" : "UT", "Virginia" : "VA", "Virgin Islands" : "VI", "Vermont" : "VT", "Washington" : "WA", "Wisconsin" : "WI", "West Virginia" : "WV", "Wyoming" : "WY"]
        
        if let streetNumber = keyValuePair["street_number"], let route = keyValuePair["route"]  {
            addressTextField.text = "\(streetNumber)" + " " + "\(route)"
        }

        if let city = keyValuePair["locality"] {
            cityTextField.text = city
        }
        
        if let stateString = keyValuePair["administrative_area_level_1"]
        {
            stateTextField.text = stateDictionary[stateString]
        }
        
        if let zipCode = keyValuePair["postal_code"]
        {
            zipcodeTextField.text = zipCode
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    
}
