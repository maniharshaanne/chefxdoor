//
//  AddNewPaymentViewController.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 9/26/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import UIKit
import FormTextField

public class AddNewPaymentViewController: UIViewController {
    
    @IBOutlet weak var cardTextField:FormTextField!
    @IBOutlet weak var expiryTextField:FormTextField!
    @IBOutlet weak var cvvTextField:FormTextField!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardBackView: UIView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        cardView.layer.cornerRadius = 5
        cardBackView.layer.cornerRadius = 5
        
        //Card text Feild
        cardTextField.inputType = .integer
        cardTextField.formatter = CardNumberFormatter()
        cardTextField.placeholder = "Card Number"
        cardTextField.backgroundColor = UIColor.white

        var validation = Validation()
        validation.maximumLength = "1234 5678 1234 5678".count
        validation.minimumLength = "1234 5678 1234 5678".count
        let characterSet = NSMutableCharacterSet.decimalDigit()
        characterSet.addCharacters(in: " ")
        validation.characterSet = characterSet as CharacterSet
        let inputValidator = InputValidator(validation: validation)
        cardTextField.inputValidator = inputValidator
        
        //Card Expiry Field
        expiryTextField.inputType = .integer
        expiryTextField.formatter = CardExpirationDateFormatter()
        expiryTextField.placeholder = "Expiration Date (MM/YY)"
        expiryTextField.backgroundColor = UIColor.white
        
        var expiryValidation = Validation()
        expiryValidation.minimumLength = 1
        let expiryInputValidator = CardExpirationDateInputValidator(validation: expiryValidation)
        expiryTextField.inputValidator = expiryInputValidator
        
        //CVV Text Field
        cvvTextField.inputType = .integer
        cvvTextField.placeholder = "CVC"
        cvvTextField.backgroundColor = UIColor.white

        var cvvValidation = Validation()
        cvvValidation.maximumLength = "CVC".count
        cvvValidation.minimumLength = "CVC".count
        cvvValidation.characterSet = NSCharacterSet.decimalDigits
        let cvvInputValidator = InputValidator(validation: cvvValidation)
        cvvTextField.inputValidator = cvvInputValidator
    }
}
