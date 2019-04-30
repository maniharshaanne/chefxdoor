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

class CXDAddReceipeViewController: UIViewController {
    
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
    @IBOutlet private weak var bottomConstraint : NSLayoutConstraint!
    
    var activeField: UITextField?
    var lastOffset: CGPoint!
    var keyboardHeight: CGFloat!
    
    override func viewDidLoad() {
        titleTextField.delegate = self
        priceTextField.delegate = self
        descriptionTextField.delegate = self
        addCategoriesTextField.delegate = self
        addIngredientsTextField.delegate = self
        addRestrcitionsTextField.delegate = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
        
        // Observe keyboard change
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    @objc func viewTapped() {
        self.view.endEditing(true)
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
    
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        let scrollPoint = CGPoint(x: 0, y: textField.frame.origin.y - 50)
//        scrollView.setContentOffset(scrollPoint, animated: true)
//    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        scrollView.setContentOffset(CGPoint.zero, animated: true)
//    }
//
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

// MARK: UITextFieldDelegate
extension CXDAddReceipeViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeField = textField
        lastOffset = self.scrollView.contentOffset
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //textField.resignFirstResponder()
        
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
        
        activeField?.resignFirstResponder()
        activeField = nil
        return true
    }
}

// MARK: Keyboard Handling
extension CXDAddReceipeViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if keyboardHeight != nil {
            return
        }
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
            
            // so increase contentView's height by keyboard height
            UIView.animate(withDuration: 0.3, animations: {
                self.bottomConstraint.constant += self.keyboardHeight + 50
            })
            
            // move if keyboard hide input field
            let distanceToBottom = self.scrollView.frame.size.height - (activeField?.frame.origin.y)! - (activeField?.frame.size.height)!
            let collapseSpace = keyboardHeight - distanceToBottom
            
            if collapseSpace < 0 {
                // no collapse
                return
            }
            
            // set new offset for scroll view
            UIView.animate(withDuration: 0.3, animations: {
                // scroll to the position above keyboard 10 points
                self.scrollView.contentOffset = CGPoint(x: self.lastOffset.x, y: collapseSpace + 10)
            })
        }
    }
    
   @objc func keyboardWillHide(notification: NSNotification) {
        
        if keyboardHeight == nil {
            return
        }
        
        UIView.animate(withDuration: 0.3) {
            self.bottomConstraint.constant -= self.keyboardHeight + 50
            
            self.scrollView.contentOffset = self.lastOffset
        }
        
        keyboardHeight = nil
    }
}
