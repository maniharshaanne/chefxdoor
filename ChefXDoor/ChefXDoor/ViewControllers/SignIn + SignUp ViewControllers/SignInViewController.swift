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
    
    var passwordAuthenticationCompletion: AWSTaskCompletionSource< AWSCognitoIdentityPasswordAuthenticationDetails>?
    var usernameText: String?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.password.text = nil
        self.username.text = usernameText
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        var curveLayer = CALayer()
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
    }
    
    @IBAction func signInPressed(_ sender: AnyObject) {
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
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
                let user = appDelegate.currentUser
                
                if (user != nil)
                    {
                        user?.getDetails().continueOnSuccessWith(block: { (userRes) -> Any? in
                            user?.getSession().continueOnSuccessWith(block: { (userSession) -> Any? in
                                
                                DispatchQueue.main.async {
                                    let getSessionResult = userSession.result
                                    appDelegate.idToken = getSessionResult?.idToken
                                    appDelegate.accessToken = getSessionResult?.accessToken
                                    
                                    // Initialize the Amazon Cognito credentials provider
                                    let credentialsProvider = AWSCognitoCredentialsProvider(regionType: .USEast1, identityPoolId: "us-east-1:d82c05b6-d3fd-4490-86c4-e3d3d39bcfb5", identityProviderManager: appDelegate)
                                    let serviceConfiguration = AWSServiceConfiguration(region:.USEast1, credentialsProvider:credentialsProvider)
                                    
                                    AWSServiceManager.default().defaultServiceConfiguration = serviceConfiguration
                                    
                                    CXDAWSApiClient.registerClient(withConfiguration: serviceConfiguration!, forKey: "USEast1CXDDEVAPIClient")
                                    
                                    // create pool configuration
                                    let poolConfiguration = AWSCognitoIdentityUserPoolConfiguration(clientId: CognitoIdentityUserPoolAppClientId,
                                                                                                    clientSecret: CognitoIdentityUserPoolAppClientSecret,
                                                                                                    poolId: CognitoIdentityUserPoolId)
                                    
                                    // initialize user pool client
                                    AWSCognitoIdentityUserPool.register(with: serviceConfiguration, userPoolConfiguration: poolConfiguration, forKey: AWSCognitoUserPoolsSignInProviderKey)
                                    
                                    // fetch the user pool client we initialized in above step
                                    appDelegate.cxdIdentityUserPool = AWSCognitoIdentityUserPool(forKey: AWSCognitoUserPoolsSignInProviderKey)
                                    appDelegate.cxdIdentityUserPool?.delegate = appDelegate
                                    
                                    appDelegate.currentUser = appDelegate.cxdIdentityUserPool?.currentUser()
                                    
                                    self.username.text = nil
                                    self.dismiss(animated: true, completion: nil)
                                    
                                }
                                return nil
                                
                            })
                            return nil

                        })
                }
                


            }
        }
    }
}


