//
//  SignInViewController+FacebookLogin.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 8/28/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import FBSDKLoginKit

extension SignInViewController{
    typealias LoginCompletionBlock = (Dictionary<String, AnyObject>?, NSError?) -> Void

    @IBAction func fbSignInPressed(_ sender: AnyObject)
    {
        basicInfoWithCompletionHandler(self) {
            (dataDictionary:Dictionary<String, AnyObject>?, error:NSError?) -> Void in
            
            print(dataDictionary ?? Dictionary<String, AnyObject>())
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK:- Public functions
    func basicInfoWithCompletionHandler(_ fromViewController:AnyObject, onCompletion: @escaping LoginCompletionBlock) -> Void {
        //Check internet connection if no internet connection then return
        getBaicInfoWithCompletionHandler(fromViewController) { (dataDictionary:Dictionary<String, AnyObject>?, error: NSError?) -> Void in
            onCompletion(dataDictionary, error)
        }
    }
    
    func logoutFromFacebook() {
        FBSDKLoginManager().logOut()
        FBSDKAccessToken.setCurrent(nil)
        FBSDKProfile.setCurrent(nil)
    }
    
    //MARK:- Private functions
    fileprivate func getBaicInfoWithCompletionHandler(_ fromViewController:AnyObject, onCompletion: @escaping LoginCompletionBlock) -> Void {
        let permissionDictionary = [
            "fields" : "id,name,first_name,last_name,gender,email,birthday,picture.type(large)",
            //"locale" : "en_US"
        ]
        if FBSDKAccessToken.current() != nil {
            FBSDKGraphRequest(graphPath: "/me", parameters: permissionDictionary)
                .start(completionHandler:  { (connection, result, error) in
                    if error == nil {
                        onCompletion(result as? Dictionary<String, AnyObject>, nil)
                    } else {
                        onCompletion(nil, error as NSError?)
                    }
                })
            
        } else {
            FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: fromViewController as! UIViewController, handler: { (result, error) -> Void in
                if error != nil {
                    FBSDKLoginManager().logOut()
                    if let error = error as NSError? {
                        let errorDetails = [NSLocalizedDescriptionKey : "Processing Error. Please try again!"]
                        let customError = NSError(domain: "Error!", code: error.code, userInfo: errorDetails)
                        onCompletion(nil, customError)
                    } else {
                        onCompletion(nil, error as NSError?)
                    }
                    
                } else if (result?.isCancelled)! {
                    FBSDKLoginManager().logOut()
                    let errorDetails = [NSLocalizedDescriptionKey : "Request cancelled!"]
                    let customError = NSError(domain: "Request cancelled!", code: 1001, userInfo: errorDetails)
                    onCompletion(nil, customError)
                } else {
//                    let loginResult: FBSDKLoginManagerLoginResult = result!
//                    if loginResult.grantedPermissions != nil {
//                        if loginResult.grantedPermissions.contains("email") {
//                            if FBSDKAccessToken.current() != nil {
//                                let tokenString = FBSDKAccessToken.current().tokenString
//                                print("FBSDKAccessToken.current() \(FBSDKAccessToken.current()) string \(String(describing: tokenString)) )")
//                                FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email, gender, birthday "]).start(completionHandler: { (connection, result, error) -> Void in
//                                    if error == nil {
//                                        let json = result as! [String : Any]
//                                        print("FBSDKGraphRequest \(json)")
//                                        let email = json["email"] as! String
//                                        let id = json["id"] as! String
//                                        let name = json["name"] as! String
//                                        let gender = json["gender"] as! String
//                                        let birthdate = json["birthday"] as! String
//                                        print("facebook login suceseeded email \(email)) id \(id) id \(name) gender \(gender) birthData \(birthdate)  ")
//
//                                        //// Sync Cognito UserPool for facebook login //////////////////
//                                        let customcedentialProvider = CustomIdentityProvider(tokens: ["graph.facebook.com" : tokenString!])
//                                        let credentialsProvider = AWSCognitoCredentialsProvider(regionType: CognitoIdentityUserPoolRegion,
//                                                                                                identityPoolId: CognitoFederatedIdentityUserPoolID,
//                                                                                                unauthRoleArn: CognitoFedratedIAMRoleUnauthARN,
//                                                                                                authRoleArn: CognitoFedratedIAMRoleAuthARN,
//                                                                                                identityProviderManager: customcedentialProvider)
//                                        let configuration = AWSServiceConfiguration(region:CognitoIdentityUserPoolRegion, credentialsProvider:credentialsProvider)
//                                        AWSServiceManager.default().defaultServiceConfiguration = configuration
//                                        credentialsProvider.getIdentityId()
//                                        print("credentialsProvider.getIdentityId() \(credentialsProvider.getIdentityId())")
//
//                                        self.navigationController?.popToRootViewController(animated: true)
//                                        self.dismiss(animated: true, completion: nil)
//                                        print("didCompleteFBLogin  ~~~~~ No Error ----- and dismiss")
//
//                                    }else{
//                                        print("FBSDKGraphRequest error")
//                                    }
//                                })
//                            }
//                        }
//                    }
                    
                    
                    
                    
                    
                    
                    let pictureRequest = FBSDKGraphRequest(graphPath: "me", parameters: permissionDictionary)
                    let _ = pictureRequest?.start(completionHandler: {
                        (connection, result, error) -> Void in
                        
                        if error == nil {
                            onCompletion(result as? Dictionary<String, AnyObject>, nil)
                        } else {
                            onCompletion(nil, error as NSError?)
                        }
                    })
                }
            })
        }
    }
}
