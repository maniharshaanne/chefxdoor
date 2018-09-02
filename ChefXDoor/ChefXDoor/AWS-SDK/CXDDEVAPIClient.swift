/*
 Copyright 2010-2016 Amazon.com, Inc. or its affiliates. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License").
 You may not use this file except in compliance with the License.
 A copy of the License is located at

 http://aws.amazon.com/apache2.0

 or in the "license" file accompanying this file. This file is distributed
 on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 express or implied. See the License for the specific language governing
 permissions and limitations under the License.
 */
 

import AWSCore
import AWSAPIGateway

public class CXDDEVAPIClient: AWSAPIGatewayClient {

	static let AWSInfoClientKey = "CXDDEVAPIClient"

	private static let _serviceClients = AWSSynchronizedMutableDictionary()
	private static let _defaultClient:CXDDEVAPIClient = {
		var serviceConfiguration: AWSServiceConfiguration? = nil
        let serviceInfo = AWSInfo.default().defaultServiceInfo(AWSInfoClientKey)
        if let serviceInfo = serviceInfo {
            serviceConfiguration = AWSServiceConfiguration(region: serviceInfo.region, credentialsProvider: serviceInfo.cognitoCredentialsProvider)
        } else if (AWSServiceManager.default().defaultServiceConfiguration != nil) {
            serviceConfiguration = AWSServiceManager.default().defaultServiceConfiguration
        } else {
            serviceConfiguration = AWSServiceConfiguration(region: .Unknown, credentialsProvider: nil)
        }
        
        return CXDDEVAPIClient(configuration: serviceConfiguration!)
	}()
    
	/**
	 Returns the singleton service client. If the singleton object does not exist, the SDK instantiates the default service client with `defaultServiceConfiguration` from `AWSServiceManager.defaultServiceManager()`. The reference to this object is maintained by the SDK, and you do not need to retain it manually.
	
	 If you want to enable AWS Signature, set the default service configuration in `func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?)`
	
	     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
	        let credentialProvider = AWSCognitoCredentialsProvider(regionType: .USEast1, identityPoolId: "YourIdentityPoolId")
	        let configuration = AWSServiceConfiguration(region: .USEast1, credentialsProvider: credentialProvider)
	        AWSServiceManager.default().defaultServiceConfiguration = configuration
	 
	        return true
	     }
	
	 Then call the following to get the default service client:
	
	     let serviceClient = CXDDEVAPIClient.default()

     Alternatively, this configuration could also be set in the `info.plist` file of your app under `AWS` dictionary with a configuration dictionary by name `CXDDEVAPIClient`.
	
	 @return The default service client.
	 */ 
	 
	public class func `default`() -> CXDDEVAPIClient{
		return _defaultClient
	}

	/**
	 Creates a service client with the given service configuration and registers it for the key.
	
	 If you want to enable AWS Signature, set the default service configuration in `func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?)`
	
	     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
	         let credentialProvider = AWSCognitoCredentialsProvider(regionType: .USEast1, identityPoolId: "YourIdentityPoolId")
	         let configuration = AWSServiceConfiguration(region: .USWest2, credentialsProvider: credentialProvider)
	         CXDDEVAPIClient.registerClient(withConfiguration: configuration, forKey: "USWest2CXDDEVAPIClient")
	
	         return true
	     }
	
	 Then call the following to get the service client:
	
	
	     let serviceClient = CXDDEVAPIClient.client(forKey: "USWest2CXDDEVAPIClient")
	
	 @warning After calling this method, do not modify the configuration object. It may cause unspecified behaviors.
	
	 @param configuration A service configuration object.
	 @param key           A string to identify the service client.
	 */
	
	public class func registerClient(withConfiguration configuration: AWSServiceConfiguration, forKey key: String){
		_serviceClients.setObject(CXDDEVAPIClient(configuration: configuration), forKey: key  as NSString);
	}

	/**
	 Retrieves the service client associated with the key. You need to call `registerClient(withConfiguration:configuration, forKey:)` before invoking this method or alternatively, set the configuration in your application's `info.plist` file. If `registerClientWithConfiguration(configuration, forKey:)` has not been called in advance or if a configuration is not present in the `info.plist` file of the app, this method returns `nil`.
	
	 For example, set the default service configuration in `func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) `
	
	     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
	         let credentialProvider = AWSCognitoCredentialsProvider(regionType: .USEast1, identityPoolId: "YourIdentityPoolId")
	         let configuration = AWSServiceConfiguration(region: .USWest2, credentialsProvider: credentialProvider)
	         CXDDEVAPIClient.registerClient(withConfiguration: configuration, forKey: "USWest2CXDDEVAPIClient")
	
	         return true
	     }
	
	 Then call the following to get the service client:
	 
	 	let serviceClient = CXDDEVAPIClient.client(forKey: "USWest2CXDDEVAPIClient")
	 
	 @param key A string to identify the service client.
	 @return An instance of the service client.
	 */
	public class func client(forKey key: String) -> CXDDEVAPIClient {
		objc_sync_enter(self)
		if let client: CXDDEVAPIClient = _serviceClients.object(forKey: key) as? CXDDEVAPIClient {
			objc_sync_exit(self)
		    return client
		}

		let serviceInfo = AWSInfo.default().defaultServiceInfo(AWSInfoClientKey)
		if let serviceInfo = serviceInfo {
			let serviceConfiguration = AWSServiceConfiguration(region: serviceInfo.region, credentialsProvider: serviceInfo.cognitoCredentialsProvider)
			CXDDEVAPIClient.registerClient(withConfiguration: serviceConfiguration!, forKey: key)
		}
		objc_sync_exit(self)
		return _serviceClients.object(forKey: key) as! CXDDEVAPIClient;
	}

	/**
	 Removes the service client associated with the key and release it.
	 
	 @warning Before calling this method, make sure no method is running on this client.
	 
	 @param key A string to identify the service client.
	 */
	public class func removeClient(forKey key: String) -> Void{
		_serviceClients.remove(key)
	}
	
	init(configuration: AWSServiceConfiguration) {
	    super.init()
	
	    self.configuration = configuration.copy() as! AWSServiceConfiguration
	    var URLString: String = "https://lb0fv6hv3e.execute-api.us-east-1.amazonaws.com/dev"
	    if URLString.hasSuffix("/") {
	        URLString = URLString.substring(to: URLString.index(before: URLString.endIndex))
	    }
	    self.configuration.endpoint = AWSEndpoint(region: configuration.regionType, service: .APIGateway, url: URL(string: URLString))
	    let signer: AWSSignatureV4Signer = AWSSignatureV4Signer(credentialsProvider: configuration.credentialsProvider, endpoint: self.configuration.endpoint)
	    if let endpoint = self.configuration.endpoint {
	    	self.configuration.baseURL = endpoint.url
	    }
	    self.configuration.requestInterceptors = [AWSNetworkingRequestInterceptor(), signer]
	}

	
    /*
     
     
     
     return type: CXDArrayOfMeal
     */
    public func mealsGet() -> AWSTask<CXDArrayOfMeal> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    let pathParameters:[String:Any] = [:]
	    
	    return self.invokeHTTPRequest("GET", urlString: "/meals", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDArrayOfMeal.self) as! AWSTask<CXDArrayOfMeal>
	}

	
    /*
     
     
     
     return type: CXDPostResponseObject
     */
    public func mealsPost() -> AWSTask<CXDPostResponseObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    let pathParameters:[String:Any] = [:]
	    
	    return self.invokeHTTPRequest("POST", urlString: "/meals", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDPostResponseObject.self) as! AWSTask<CXDPostResponseObject>
	}

	
    /*
     
     
     
     return type: 
     */
    public func mealsOptions() -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    let pathParameters:[String:Any] = [:]
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/meals", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     
     return type: CXDArrayOfMealCategory
     */
    public func mealsCategoriesGet() -> AWSTask<CXDArrayOfMealCategory> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    let pathParameters:[String:Any] = [:]
	    
	    return self.invokeHTTPRequest("GET", urlString: "/meals/categories", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDArrayOfMealCategory.self) as! AWSTask<CXDArrayOfMealCategory>
	}

	
    /*
     
     
     
     return type: 
     */
    public func mealsCategoriesOptions() -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    let pathParameters:[String:Any] = [:]
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/meals/categories", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     @param categoryId 
     
     return type: CXDArrayOfMeal
     */
    public func mealsCategoriesCategoryIdGet(categoryId: String) -> AWSTask<CXDArrayOfMeal> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["category_id"] = categoryId
	    
	    return self.invokeHTTPRequest("GET", urlString: "/meals/categories/{categoryId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDArrayOfMeal.self) as! AWSTask<CXDArrayOfMeal>
	}

	
    /*
     
     
     @param categoryId 
     
     return type: 
     */
    public func mealsCategoriesCategoryIdOptions(categoryId: String) -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["category_id"] = categoryId
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/meals/categories/{categoryId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     
     return type: CXDArrayOfMeal
     */
    public func mealsRecommendedGet() -> AWSTask<CXDArrayOfMeal> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    let pathParameters:[String:Any] = [:]
	    
	    return self.invokeHTTPRequest("GET", urlString: "/meals/recommended", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDArrayOfMeal.self) as! AWSTask<CXDArrayOfMeal>
	}

	
    /*
     
     
     
     return type: 
     */
    public func mealsRecommendedOptions() -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    let pathParameters:[String:Any] = [:]
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/meals/recommended", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     @param mealId 
     
     return type: CXDMeal
     */
    public func mealsMealIdGet(mealId: String) -> AWSTask<CXDMeal> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["meal_id"] = mealId
	    
	    return self.invokeHTTPRequest("GET", urlString: "/meals/{mealId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDMeal.self) as! AWSTask<CXDMeal>
	}

	
    /*
     
     
     @param mealId 
     
     return type: CXDPostResponseObject
     */
    public func mealsMealIdPut(mealId: String) -> AWSTask<CXDPostResponseObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["meal_id"] = mealId
	    
	    return self.invokeHTTPRequest("PUT", urlString: "/meals/{mealId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDPostResponseObject.self) as! AWSTask<CXDPostResponseObject>
	}

	
    /*
     
     
     @param mealId 
     
     return type: 
     */
    public func mealsMealIdOptions(mealId: String) -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["meal_id"] = mealId
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/meals/{mealId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     @param mealId 
     
     return type: CXDMeal
     */
    public func mealsMealIdPhotosGet(mealId: String) -> AWSTask<CXDMeal> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["meal_id"] = mealId
	    
	    return self.invokeHTTPRequest("GET", urlString: "/meals/{mealId}/photos", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDMeal.self) as! AWSTask<CXDMeal>
	}

	
    /*
     
     
     @param mealId 
     
     return type: CXDPostResponseObject
     */
    public func mealsMealIdPhotosPost(mealId: String) -> AWSTask<CXDPostResponseObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["meal_id"] = mealId
	    
	    return self.invokeHTTPRequest("POST", urlString: "/meals/{mealId}/photos", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDPostResponseObject.self) as! AWSTask<CXDPostResponseObject>
	}

	
    /*
     
     
     @param mealId 
     
     return type: 
     */
    public func mealsMealIdPhotosOptions(mealId: String) -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["meal_id"] = mealId
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/meals/{mealId}/photos", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     @param photoId 
     @param mealId 
     
     return type: CXDMealPhoto
     */
    public func mealsMealIdPhotosPhotoIdGet(photoId: String, mealId: String) -> AWSTask<CXDMealPhoto> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["photo_id"] = photoId
	    pathParameters["meal_id"] = mealId
	    
	    return self.invokeHTTPRequest("GET", urlString: "/meals/{mealId}/photos/{photoId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDMealPhoto.self) as! AWSTask<CXDMealPhoto>
	}

	
    /*
     
     
     @param photoId 
     @param mealId 
     
     return type: CXDPostResponseObject
     */
    public func mealsMealIdPhotosPhotoIdPut(photoId: String, mealId: String) -> AWSTask<CXDPostResponseObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["photo_id"] = photoId
	    pathParameters["meal_id"] = mealId
	    
	    return self.invokeHTTPRequest("PUT", urlString: "/meals/{mealId}/photos/{photoId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDPostResponseObject.self) as! AWSTask<CXDPostResponseObject>
	}

	
    /*
     
     
     @param photoId 
     @param mealId 
     
     return type: 
     */
    public func mealsMealIdPhotosPhotoIdOptions(photoId: String, mealId: String) -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["photo_id"] = photoId
	    pathParameters["meal_id"] = mealId
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/meals/{mealId}/photos/{photoId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     @param mealId 
     
     return type: CXDMeal
     */
    public func mealsMealIdReviewsGet(mealId: String) -> AWSTask<CXDMeal> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["meal_id"] = mealId
	    
	    return self.invokeHTTPRequest("GET", urlString: "/meals/{mealId}/reviews", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDMeal.self) as! AWSTask<CXDMeal>
	}

	
    /*
     
     
     @param mealId 
     
     return type: CXDPostResponseObject
     */
    public func mealsMealIdReviewsPost(mealId: String) -> AWSTask<CXDPostResponseObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["meal_id"] = mealId
	    
	    return self.invokeHTTPRequest("POST", urlString: "/meals/{mealId}/reviews", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDPostResponseObject.self) as! AWSTask<CXDPostResponseObject>
	}

	
    /*
     
     
     @param mealId 
     
     return type: 
     */
    public func mealsMealIdReviewsOptions(mealId: String) -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["meal_id"] = mealId
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/meals/{mealId}/reviews", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     @param reviewId 
     @param mealId 
     
     return type: CXDMealReview
     */
    public func mealsMealIdReviewsReviewIdGet(reviewId: String, mealId: String) -> AWSTask<CXDMealReview> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["review_id"] = reviewId
	    pathParameters["meal_id"] = mealId
	    
	    return self.invokeHTTPRequest("GET", urlString: "/meals/{mealId}/reviews/{reviewId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDMealReview.self) as! AWSTask<CXDMealReview>
	}

	
    /*
     
     
     @param reviewId 
     @param mealId 
     
     return type: CXDPostResponseObject
     */
    public func mealsMealIdReviewsReviewIdPut(reviewId: String, mealId: String) -> AWSTask<CXDPostResponseObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["review_id"] = reviewId
	    pathParameters["meal_id"] = mealId
	    
	    return self.invokeHTTPRequest("PUT", urlString: "/meals/{mealId}/reviews/{reviewId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDPostResponseObject.self) as! AWSTask<CXDPostResponseObject>
	}

	
    /*
     
     
     @param reviewId 
     @param mealId 
     
     return type: 
     */
    public func mealsMealIdReviewsReviewIdOptions(reviewId: String, mealId: String) -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["review_id"] = reviewId
	    pathParameters["meal_id"] = mealId
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/meals/{mealId}/reviews/{reviewId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     
     return type: CXDArrayOfUser
     */
    public func usersGet() -> AWSTask<CXDArrayOfUser> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    let pathParameters:[String:Any] = [:]
	    
	    return self.invokeHTTPRequest("GET", urlString: "/users", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDArrayOfUser.self) as! AWSTask<CXDArrayOfUser>
	}

	
    /*
     
     
     
     return type: CXDPostResponseObject
     */
    public func usersPost() -> AWSTask<CXDPostResponseObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    let pathParameters:[String:Any] = [:]
	    
	    return self.invokeHTTPRequest("POST", urlString: "/users", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDPostResponseObject.self) as! AWSTask<CXDPostResponseObject>
	}

	
    /*
     
     
     
     return type: 
     */
    public func usersOptions() -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    let pathParameters:[String:Any] = [:]
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/users", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     
     return type: CXDUser
     */
    public func usersCurrentuserGet() -> AWSTask<CXDUser> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    let pathParameters:[String:Any] = [:]
	    
	    return self.invokeHTTPRequest("GET", urlString: "/users/currentuser", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDUser.self) as! AWSTask<CXDUser>
	}

	
    /*
     
     
     
     return type: CXDPostResponseObject
     */
    public func usersCurrentuserPut() -> AWSTask<CXDPostResponseObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    let pathParameters:[String:Any] = [:]
	    
	    return self.invokeHTTPRequest("PUT", urlString: "/users/currentuser", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDPostResponseObject.self) as! AWSTask<CXDPostResponseObject>
	}

	
    /*
     
     
     
     return type: 
     */
    public func usersCurrentuserOptions() -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    let pathParameters:[String:Any] = [:]
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/users/currentuser", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     @param userId 
     
     return type: CXDUser
     */
    public func usersUserIdGet(userId: String) -> AWSTask<CXDUser> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("GET", urlString: "/users/{userId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDUser.self) as! AWSTask<CXDUser>
	}

	
    /*
     
     
     @param userId 
     
     return type: CXDPostResponseObject
     */
    public func usersUserIdPut(userId: String) -> AWSTask<CXDPostResponseObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("PUT", urlString: "/users/{userId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDPostResponseObject.self) as! AWSTask<CXDPostResponseObject>
	}

	
    /*
     
     
     @param userId 
     
     return type: 
     */
    public func usersUserIdOptions(userId: String) -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/users/{userId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     @param userId 
     
     return type: CXDArrayOfBilling
     */
    public func usersUserIdBillingGet(userId: String) -> AWSTask<CXDArrayOfBilling> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("GET", urlString: "/users/{userId}/billing", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDArrayOfBilling.self) as! AWSTask<CXDArrayOfBilling>
	}

	
    /*
     
     
     @param userId 
     
     return type: CXDPostResponseObject
     */
    public func usersUserIdBillingPost(userId: String) -> AWSTask<CXDPostResponseObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("POST", urlString: "/users/{userId}/billing", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDPostResponseObject.self) as! AWSTask<CXDPostResponseObject>
	}

	
    /*
     
     
     @param userId 
     
     return type: 
     */
    public func usersUserIdBillingOptions(userId: String) -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/users/{userId}/billing", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     @param billingId 
     @param userId 
     
     return type: CXDOrders
     */
    public func usersUserIdBillingBillingIdGet(billingId: String, userId: String) -> AWSTask<CXDOrders> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["billing_id"] = billingId
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("GET", urlString: "/users/{userId}/billing/{billingId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDOrders.self) as! AWSTask<CXDOrders>
	}

	
    /*
     
     
     @param billingId 
     @param userId 
     
     return type: CXDPostResponseObject
     */
    public func usersUserIdBillingBillingIdPut(billingId: String, userId: String) -> AWSTask<CXDPostResponseObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["billing_id"] = billingId
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("PUT", urlString: "/users/{userId}/billing/{billingId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDPostResponseObject.self) as! AWSTask<CXDPostResponseObject>
	}

	
    /*
     
     
     @param billingId 
     @param userId 
     
     return type: 
     */
    public func usersUserIdBillingBillingIdOptions(billingId: String, userId: String) -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["billing_id"] = billingId
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/users/{userId}/billing/{billingId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     @param userId 
     
     return type: CXDMeal
     */
    public func usersUserIdFavoritemealsGet(userId: String) -> AWSTask<CXDMeal> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("GET", urlString: "/users/{userId}/favoritemeals", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDMeal.self) as! AWSTask<CXDMeal>
	}

	
    /*
     
     
     @param userId 
     
     return type: 
     */
    public func usersUserIdFavoritemealsOptions(userId: String) -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/users/{userId}/favoritemeals", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     @param userId 
     
     return type: CXDOrders
     */
    public func usersUserIdOrdersGet(userId: String) -> AWSTask<CXDOrders> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("GET", urlString: "/users/{userId}/orders", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDOrders.self) as! AWSTask<CXDOrders>
	}

	
    /*
     
     
     @param userId 
     
     return type: CXDPostResponseObject
     */
    public func usersUserIdOrdersPost(userId: String) -> AWSTask<CXDPostResponseObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("POST", urlString: "/users/{userId}/orders", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDPostResponseObject.self) as! AWSTask<CXDPostResponseObject>
	}

	
    /*
     
     
     @param userId 
     
     return type: 
     */
    public func usersUserIdOrdersOptions(userId: String) -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/users/{userId}/orders", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     @param userId 
     @param orderId 
     
     return type: CXDOrders
     */
    public func usersUserIdOrdersOrderIdGet(userId: String, orderId: String) -> AWSTask<CXDOrders> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    pathParameters["order_id"] = orderId
	    
	    return self.invokeHTTPRequest("GET", urlString: "/users/{userId}/orders/{orderId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDOrders.self) as! AWSTask<CXDOrders>
	}

	
    /*
     
     
     @param userId 
     @param orderId 
     
     return type: CXDPostResponseObject
     */
    public func usersUserIdOrdersOrderIdPut(userId: String, orderId: String) -> AWSTask<CXDPostResponseObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    pathParameters["order_id"] = orderId
	    
	    return self.invokeHTTPRequest("PUT", urlString: "/users/{userId}/orders/{orderId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDPostResponseObject.self) as! AWSTask<CXDPostResponseObject>
	}

	
    /*
     
     
     @param userId 
     @param orderId 
     
     return type: 
     */
    public func usersUserIdOrdersOrderIdOptions(userId: String, orderId: String) -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    pathParameters["order_id"] = orderId
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/users/{userId}/orders/{orderId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     @param userId 
     
     return type: CXDMealReview
     */
    public func usersUserIdReviewsGet(userId: String) -> AWSTask<CXDMealReview> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("GET", urlString: "/users/{userId}/reviews", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDMealReview.self) as! AWSTask<CXDMealReview>
	}

	
    /*
     
     
     @param userId 
     
     return type: CXDPostResponseObject
     */
    public func usersUserIdReviewsPost(userId: String) -> AWSTask<CXDPostResponseObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("POST", urlString: "/users/{userId}/reviews", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDPostResponseObject.self) as! AWSTask<CXDPostResponseObject>
	}

	
    /*
     
     
     @param userId 
     
     return type: 
     */
    public func usersUserIdReviewsOptions(userId: String) -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/users/{userId}/reviews", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     @param reviewId 
     @param userId 
     
     return type: CXDUserReview
     */
    public func usersUserIdReviewsReviewIdGet(reviewId: String, userId: String) -> AWSTask<CXDUserReview> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["review_id"] = reviewId
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("GET", urlString: "/users/{userId}/reviews/{reviewId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDUserReview.self) as! AWSTask<CXDUserReview>
	}

	
    /*
     
     
     @param reviewId 
     @param userId 
     
     return type: CXDPostResponseObject
     */
    public func usersUserIdReviewsReviewIdPut(reviewId: String, userId: String) -> AWSTask<CXDPostResponseObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["review_id"] = reviewId
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("PUT", urlString: "/users/{userId}/reviews/{reviewId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDPostResponseObject.self) as! AWSTask<CXDPostResponseObject>
	}

	
    /*
     
     
     @param reviewId 
     @param userId 
     
     return type: 
     */
    public func usersUserIdReviewsReviewIdOptions(reviewId: String, userId: String) -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["review_id"] = reviewId
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/users/{userId}/reviews/{reviewId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     
     return type: 
     */
    public func proxyOptions() -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    let pathParameters:[String:Any] = [:]
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/{proxy+}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}




}
