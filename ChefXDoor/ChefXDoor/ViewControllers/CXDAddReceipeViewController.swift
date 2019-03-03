//
//  CXDAddReceipeViewController.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 2/11/19.
//  Copyright © 2019 ChefXDoor. All rights reserved.
//

import Foundation
import UIKit
import TagListView

class CXDAddReceipeViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var categoriesTagListView: TagListView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var prepTimeHrLabel: UILabel!
    @IBOutlet weak var prepTimeMinLabel: UILabel!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var addCategoriesTextField: UITextField!
    @IBOutlet weak var addIngredientsTextField: UITextField!
    @IBOutlet weak var addRestrcitionsTextField: UITextField!
    @IBOutlet weak var ingredientsTagListView: TagListView!
    @IBOutlet weak var restrictionsTagListView: TagListView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        titleTextField.delegate = self
        priceTextField.delegate = self
        descriptionTextField.delegate = self
        addCategoriesTextField.delegate = self
        addIngredientsTextField.delegate = self
        addRestrcitionsTextField.delegate = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
    }
    
    @objc func viewTapped() {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        switch textField.tag {
        case 111:
            if let category = addCategoriesTextField.text
            {
                categoriesTagListView.addTag(category)
            }
        case 222:
            if let ingredient = addIngredientsTextField.text
            {
                ingredientsTagListView.addTag(ingredient)
            }
        case 333:
            if let restriction = addRestrcitionsTextField.text
            {
                restrictionsTagListView.addTag(restriction)
            }
        default:
            break
        }

        return true
    }
    
    @IBAction func prepTimePlusButtonPressed(_ sender: Any) {
        if let hr = Int(prepTimeHrLabel.text ?? "0"), let min = Int(prepTimeMinLabel.text ?? "15"){
            if hr < 4 {
                if min == 45 {
                    prepTimeMinLabel.text = "00"
                    prepTimeHrLabel.text = "\(hr + 1)"
                } else {
                    prepTimeMinLabel.text = "\(min + 15)"
                }
            } else if hr == 4 {
                
            }
        }
    }
    
    @IBAction func prepTimeMinusButtonPressed(_ sender: Any) {
        if let hr = Int(prepTimeHrLabel.text ?? "0"), let min = Int(prepTimeMinLabel.text ?? "15"){
            if hr > 0 {
                if min == 0 {
                    prepTimeMinLabel.text = "45"
                    prepTimeHrLabel.text = "\(hr - 1)"
                } else {
                    prepTimeMinLabel.text = "\(min - 15)"
                }
            } else if hr == 0 {
                if min > 15
                {
                    prepTimeMinLabel.text = "\(min - 15)"
                }
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let scrollPoint = CGPoint(x: 0, y: textField.frame.origin.y - 50)
        scrollView.setContentOffset(scrollPoint, animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint.zero, animated: true)
    }
    
    @IBAction func qtyPlusButtonPressed(_ sender: Any) {
        if let count = Int(quantityLabel.text ?? "1")
        {
            quantityLabel.text = "\(count + 1)"
        }
    }
    
    @IBAction func qtyMinusButtonPressed(_ sender: Any) {
        if let count = Int(quantityLabel.text ?? "1") , count > 1
        {
            quantityLabel.text = "\(count - 1)"
        }
    }
    
}
