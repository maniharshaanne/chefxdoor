//
//  AppDelegate.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 6/9/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import UIKit
import AWSCognito
import AWSCognitoIdentityProvider
import FBSDKCoreKit
import FAPanels
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder,UIApplicationDelegate,AWSIdentityProviderManager  {
    
    var window: UIWindow?
    var signInViewController: SignInViewController?
    var mfaViewController: MFAViewController?
    var navigationController: UINavigationController?
    var storyboard: UIStoryboard?
    var rememberDeviceCompletionSource: AWSTaskCompletionSource<NSNumber>?
    public var cxdIdentityUserPool: AWSCognitoIdentityUserPool?
    public var currentUser: AWSCognitoIdentityUser?
    public var idToken:AWSCognitoIdentityUserSessionToken?
    public var accessToken:AWSCognitoIdentityUserSessionToken?
    public var refreshToken:AWSCognitoIdentityUserSessionToken?
    public var isUpdateTokenRequired:Bool = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions:
                launchOptions)
        
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = UIColor.white
        navigationBarAppearace.barTintColor = CXDAppearance.primaryBackgroundDarkColor()
        
        let searchBarAppearance = UISearchBar.appearance()
        searchBarAppearance.tintColor = UIColor.white

        setupRootViewController()
        setupAWSConfiguration()
        
        GMSPlacesClient.provideAPIKey("AIzaSyDCw94KcJOSTK9gqhbFFhNyAy4eDxSGeE8")

        return true
    }
    
    func setupRootViewController() {
        //Setup up rootViewController
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let leftMenuVC: LeftMenuViewController = mainStoryboard.instantiateViewController(withIdentifier: "MenuViewController") as! LeftMenuViewController
        let recommendationsViewController: RecommendationsViewController = mainStoryboard.instantiateViewController(withIdentifier: "RecommendationsViewController") as! RecommendationsViewController
        let recommendationsNavVC = UINavigationController(rootViewController: recommendationsViewController)
        
        let rootController: FAPanelController = self.window?.rootViewController as! FAPanelController
        
        rootController.configs.rightPanelWidth = 80
        rootController.configs.bounceOnRightPanelOpen = false
        if #available(iOS 11.0, *) {
            rootController.prefersHomeIndicatorAutoHidden()
        } else {
            // Fallback on earlier versions
        }
        _ = rootController.center(recommendationsNavVC).left(leftMenuVC)
        
        self.storyboard = UIStoryboard(name: "Login", bundle: nil)
    }
    
    func setupAWSConfiguration()
    {
        isUpdateTokenRequired = true
        // Warn user if configuration not updated
        if (CognitoIdentityUserPoolId == "us-east-1_8RENSlJ3A") {
            let alertController = UIAlertController(title: "Invalid Configuration",
                                                    message: "Please configure user pool constants in Constants.swift file.",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.window?.rootViewController!.present(alertController, animated: true, completion:  nil)
        }
        
        // setup logging
        AWSDDLog.sharedInstance.logLevel = .verbose
        
        // setup service configuration
        let serviceConfiguration = AWSServiceConfiguration(region:.USEast1, credentialsProvider:nil)
        
        AWSServiceManager.default().defaultServiceConfiguration = serviceConfiguration

        CXDAWSApiClient.registerClient(withConfiguration: serviceConfiguration!, forKey: "USEast1CXDDEVAPIClient")
        
        // create pool configuration
        let poolConfiguration = AWSCognitoIdentityUserPoolConfiguration(clientId: CognitoIdentityUserPoolAppClientId,
                                                                        clientSecret: CognitoIdentityUserPoolAppClientSecret,
                                                                        poolId: CognitoIdentityUserPoolId)
        
        // initialize user pool client
        AWSCognitoIdentityUserPool.register(with: serviceConfiguration, userPoolConfiguration: poolConfiguration, forKey: AWSCognitoUserPoolsSignInProviderKey)
        
        // fetch the user pool client we initialized in above step
        cxdIdentityUserPool = AWSCognitoIdentityUserPool(forKey: AWSCognitoUserPoolsSignInProviderKey)
        currentUser = cxdIdentityUserPool?.currentUser()
        cxdIdentityUserPool?.delegate = self
    }
    
    func setupAWSConfiguration(userSession: AWSCognitoIdentityUserSession)
    {
        isUpdateTokenRequired = false
        self.idToken = userSession.idToken
        self.accessToken = userSession.accessToken
        self.refreshToken = userSession.refreshToken
        
        // Initialize the Amazon Cognito credentials provider
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType: .USEast1, identityPoolId: CognitoIdentityPoolId, identityProviderManager: self)
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
        self.cxdIdentityUserPool = AWSCognitoIdentityUserPool(forKey: AWSCognitoUserPoolsSignInProviderKey)
        self.cxdIdentityUserPool?.delegate = self
        self.currentUser = self.cxdIdentityUserPool?.currentUser()
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool{
        return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    
    func logins() -> AWSTask<NSDictionary>
    {
        if let token = FBSDKAccessToken.current()?.tokenString {
            return AWSTask(result: [AWSIdentityProviderFacebook:token])
        }
        
        if let token = self.idToken?.tokenString
        {
            return AWSTask(result: [CognitoUserPoolTokenString : token])
        }
        
        return AWSTask(error:NSError(domain: "Login", code: -1 , userInfo: ["NoToken" : "No current Facebook access token"]))
    }
}

// MARK:- AWSCognitoIdentityInteractiveAuthenticationDelegate protocol delegate

extension AppDelegate: AWSCognitoIdentityInteractiveAuthenticationDelegate {
    
    func startPasswordAuthentication() -> AWSCognitoIdentityPasswordAuthentication {
        if (self.navigationController == nil) {
            self.navigationController = self.storyboard?.instantiateViewController(withIdentifier: "signinController") as? UINavigationController
        }
        
        if (self.signInViewController == nil) {
            self.signInViewController = self.navigationController?.viewControllers[0] as? SignInViewController
        }
        
        DispatchQueue.main.async {
            self.navigationController!.popToRootViewController(animated: true)
            if (!self.navigationController!.isViewLoaded
                || self.navigationController!.view.window == nil) {
                self.window?.rootViewController?.present(self.navigationController!,
                                                         animated: true,
                                                         completion: nil)
            }
            
        }
        return self.signInViewController!
    }
    
    func startMultiFactorAuthentication() -> AWSCognitoIdentityMultiFactorAuthentication {
        if (self.mfaViewController == nil) {
            self.mfaViewController = MFAViewController()
            self.mfaViewController?.modalPresentationStyle = .popover
        }
        DispatchQueue.main.async {
            if (!self.mfaViewController!.isViewLoaded
                || self.mfaViewController!.view.window == nil) {
                //display mfa as popover on current view controller
                let viewController = self.window?.rootViewController!
                viewController?.present(self.mfaViewController!,
                                        animated: true,
                                        completion: nil)
                
                // configure popover vc
                let presentationController = self.mfaViewController!.popoverPresentationController
                presentationController?.permittedArrowDirections = UIPopoverArrowDirection.left
                presentationController?.sourceView = viewController!.view
                presentationController?.sourceRect = viewController!.view.bounds
            }
        }
        return self.mfaViewController!
    }
    
    func startRememberDevice() -> AWSCognitoIdentityRememberDevice {
        return self
    }
}

// MARK:- AWSCognitoIdentityRememberDevice protocol delegate

extension AppDelegate: AWSCognitoIdentityRememberDevice {
    
    func getRememberDevice(_ rememberDeviceCompletionSource: AWSTaskCompletionSource<NSNumber>) {
        self.rememberDeviceCompletionSource = rememberDeviceCompletionSource
        DispatchQueue.main.async {
            // dismiss the view controller being present before asking to remember device
            self.window?.rootViewController!.presentedViewController?.dismiss(animated: true, completion: nil)
            let alertController = UIAlertController(title: "Remember Device",
                                                    message: "Do you want to remember this device?.",
                                                    preferredStyle: .actionSheet)
            
            let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                self.rememberDeviceCompletionSource?.set(result: true)
            })
            let noAction = UIAlertAction(title: "No", style: .default, handler: { (action) in
                self.rememberDeviceCompletionSource?.set(result: false)
            })
            alertController.addAction(yesAction)
            alertController.addAction(noAction)
            
            self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    func didCompleteStepWithError(_ error: Error?) {
        DispatchQueue.main.async {
            if let error = error as NSError? {
                let alertController = UIAlertController(title: error.userInfo["__type"] as? String,
                                                        message: error.userInfo["message"] as? String,
                                                        preferredStyle: .alert)
                let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
                alertController.addAction(okAction)
                DispatchQueue.main.async {
                    self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}


