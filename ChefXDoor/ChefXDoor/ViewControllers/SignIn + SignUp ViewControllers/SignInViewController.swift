//
//  SignInViewController.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 6/14/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import AWSCognito
import AWSCognitoIdentityProvider
import FBSDKLoginKit

class SignInViewController: UIViewController, AWSCognitoIdentityPasswordAuthentication {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var curveView:UIView!
    @IBOutlet weak var loginButtonView: UIView!
    @IBOutlet weak var googleSignupButton: UIButton!
    @IBOutlet weak var facebookSignupButton:UIButton!
    
    var passwordAuthenticationCompletion: AWSTaskCompletionSource< AWSCognitoIdentityPasswordAuthenticationDetails>?
    var usernameText: String?

    override func viewDidLoad() {
        let curveLayer = CALayer()
        curveView.layer.insertSublayer(curveLayer, at: 0)
        
        let layer = curveView.layer
        layer.cornerRadius = 70
        
        layer.shadowOffset = CGSize(width: 4, height: 4)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 5.0
        
        curveLayer.frame = layer.bounds
        curveLayer.masksToBounds = true
        curveLayer.cornerRadius = layer.cornerRadius
        curveLayer.borderColor = UIColor.white.cgColor
        curveLayer.borderWidth = 3.0
        curveLayer.backgroundColor = UIColor(red: 51/256, green: 51/256, blue: 51/256, alpha: 0.7).cgColor
        
        if #available(iOS 11.0, *) {
            curveLayer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
        
        loginButtonView.layer.cornerRadius = 25
        loginButtonView.layer.masksToBounds = true
        
        googleSignupButton.layer.cornerRadius = 20
        facebookSignupButton.layer.cornerRadius = 20
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.password.text = nil
        self.username.text = usernameText
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func signInPressed(_ sender: AnyObject) {
        //AWSServiceManager.default().defaultServiceConfiguration.credentialsProvider.invalidateCachedTemporaryCredentials()
        if (self.username.text != nil && self.password.text != nil) {
            let authDetails = AWSCognitoIdentityPasswordAuthenticationDetails(username: self.username.text!, password: self.password.text!)
            self.passwordAuthenticationCompletion?.set(result: authDetails)
        } else {
            let alertController = UIAlertController(title: "Missing information",
                                                    message: "Please enter a valid user name and password",
                                                    preferredStyle: .alert)
            let retryAction = UIAlertAction(title: "Retry", style: .default, handler: nil)
            alertController.addAction(retryAction)
        }
    }
    
    public func getDetails(_ authenticationInput: AWSCognitoIdentityPasswordAuthenticationInput, passwordAuthenticationCompletionSource: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>) {
        self.passwordAuthenticationCompletion = passwordAuthenticationCompletionSource
        DispatchQueue.main.async {
            if (self.usernameText == nil) {
                self.usernameText = authenticationInput.lastKnownUsername
            }
        }
    }

    public func didCompleteStepWithError(_ error: Error?) {
        DispatchQueue.main.async {
            if let error = error as NSError? {
                let alertController = UIAlertController(title: error.userInfo["__type"] as? String,
                                                        message: error.userInfo["message"] as? String,
                                                        preferredStyle: .alert)
                let retryAction = UIAlertAction(title: "Retry", style: .default, handler: nil)
                alertController.addAction(retryAction)
                
                self.present(alertController, animated: true, completion:  nil)
            } else {
                self.updateUserToken()
            }
        }
    }

    func updateUserToken()  {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let pool = appDelegate.cxdIdentityUserPool

        if let user = pool?.currentUser() {
            user.getSession(self.username.text!, password: self.password.text!, validationData: nil).continueOnSuccessWith(block: { (userSession) -> Any? in
                DispatchQueue.main.async {
                   if let getSessionResult = userSession.result
                   {
                        getSessionResult.refreshToken
                        appDelegate.setupAWSConfiguration(userSession: getSessionResult)
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            })
        }
    }
}

