/*
 Copyright 2010-2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.

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
	    var URLString: String = "https://b6gptpccx3.execute-api.us-east-1.amazonaws.com/dev"
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
     
     
     @param chefId 
     @param lat 
     @param sort 
     @param distance 
     @param page 
     @param long 
     
     return type: CXDArrayOfMeal
     */
    public func mealsGet(chefId: String?, lat: String?, sort: String?, distance: String?, page: String?, long: String?) -> AWSTask<CXDArrayOfMeal> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    var queryParameters:[String:Any] = [:]
	    queryParameters["chef_id"] = chefId
	    queryParameters["lat"] = lat
	    queryParameters["sort"] = sort
	    queryParameters["distance"] = distance
	    queryParameters["page"] = page
	    queryParameters["long"] = long
	    
	    let pathParameters:[String:Any] = [:]
	    
	    return self.invokeHTTPRequest("GET", urlString: "/meals", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDArrayOfMeal.self) as! AWSTask<CXDArrayOfMeal>
	}

	
    /*
     
     
     @param body 
     
     return type: CXDMeal
     */
    public func mealsPost(body: CXDMeal) -> AWSTask<CXDMeal> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    let pathParameters:[String:Any] = [:]
	    
	    return self.invokeHTTPRequest("POST", urlString: "/meals", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: body, responseClass: CXDMeal.self) as! AWSTask<CXDMeal>
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
     
     
     @param lat 
     @param sort 
     @param distance 
     @param page 
     @param long 
     
     return type: CXDArrayOfMealCategory
     */
    public func mealsCategoriesGet(lat: String?, sort: String?, distance: String?, page: String?, long: String?) -> AWSTask<CXDArrayOfMealCategory> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    var queryParameters:[String:Any] = [:]
	    queryParameters["lat"] = lat
	    queryParameters["sort"] = sort
	    queryParameters["distance"] = distance
	    queryParameters["page"] = page
	    queryParameters["long"] = long
	    
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
     @param lat 
     @param sort 
     @param distance 
     @param page 
     @param long 
     
     return type: CXDArrayOfMeal
     */
    public func mealsCategoriesCategoryIdGet(categoryId: String, lat: String?, sort: String?, distance: String?, page: String?, long: String?) -> AWSTask<CXDArrayOfMeal> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    var queryParameters:[String:Any] = [:]
	    queryParameters["lat"] = lat
	    queryParameters["sort"] = sort
	    queryParameters["distance"] = distance
	    queryParameters["page"] = page
	    queryParameters["long"] = long
	    
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
     
     
     @param lat 
     @param sort 
     @param distance 
     @param page 
     @param long 
     
     return type: CXDArrayOfMeal
     */
    public func mealsRecommendedGet(lat: String?, sort: String?, distance: String?, page: String?, long: String?) -> AWSTask<CXDArrayOfMeal> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    var queryParameters:[String:Any] = [:]
	    queryParameters["lat"] = lat
	    queryParameters["sort"] = sort
	    queryParameters["distance"] = distance
	    queryParameters["page"] = page
	    queryParameters["long"] = long
	    
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
     @param body 
     
     return type: CXDMeal
     */
    public func mealsMealIdPut(mealId: String, body: CXDMeal) -> AWSTask<CXDMeal> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["meal_id"] = mealId
	    
	    return self.invokeHTTPRequest("PUT", urlString: "/meals/{mealId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: body, responseClass: CXDMeal.self) as! AWSTask<CXDMeal>
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
     
     return type: CXDArrayOfMealPhoto
     */
    public func mealsMealIdPhotosGet(mealId: String) -> AWSTask<CXDArrayOfMealPhoto> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["meal_id"] = mealId
	    
	    return self.invokeHTTPRequest("GET", urlString: "/meals/{mealId}/photos", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDArrayOfMealPhoto.self) as! AWSTask<CXDArrayOfMealPhoto>
	}

	
    /*
     
     
     @param mealId 
     @param body 
     
     return type: CXDArrayOfMealPhoto
     */
    public func mealsMealIdPhotosPost(mealId: String, body: CXDArrayOfMealPhoto) -> AWSTask<CXDArrayOfMealPhoto> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["meal_id"] = mealId
	    
	    return self.invokeHTTPRequest("POST", urlString: "/meals/{mealId}/photos", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: body, responseClass: CXDArrayOfMealPhoto.self) as! AWSTask<CXDArrayOfMealPhoto>
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
     @param body 
     
     return type: CXDUserPhoto
     */
    public func mealsMealIdPhotosPhotoIdPut(photoId: String, mealId: String, body: CXDMealPhoto) -> AWSTask<CXDUserPhoto> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["photo_id"] = photoId
	    pathParameters["meal_id"] = mealId
	    
	    return self.invokeHTTPRequest("PUT", urlString: "/meals/{mealId}/photos/{photoId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: body, responseClass: CXDUserPhoto.self) as! AWSTask<CXDUserPhoto>
	}

	
    /*
     
     
     @param photoId 
     @param mealId 
     
     return type: CXDTransactionResult
     */
    public func mealsMealIdPhotosPhotoIdDelete(photoId: String, mealId: String) -> AWSTask<CXDTransactionResult> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["photo_id"] = photoId
	    pathParameters["meal_id"] = mealId
	    
	    return self.invokeHTTPRequest("DELETE", urlString: "/meals/{mealId}/photos/{photoId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDTransactionResult.self) as! AWSTask<CXDTransactionResult>
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
     @param page 
     
     return type: CXDArrayOfMealReview
     */
    public func mealsMealIdReviewsGet(mealId: String, page: String?) -> AWSTask<CXDArrayOfMealReview> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    var queryParameters:[String:Any] = [:]
	    queryParameters["page"] = page
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["meal_id"] = mealId
	    
	    return self.invokeHTTPRequest("GET", urlString: "/meals/{mealId}/reviews", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDArrayOfMealReview.self) as! AWSTask<CXDArrayOfMealReview>
	}

	
    /*
     
     
     @param mealId 
     @param body 
     
     return type: CXDMealReview
     */
    public func mealsMealIdReviewsPost(mealId: String, body: CXDMealReview) -> AWSTask<CXDMealReview> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["meal_id"] = mealId
	    
	    return self.invokeHTTPRequest("POST", urlString: "/meals/{mealId}/reviews", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: body, responseClass: CXDMealReview.self) as! AWSTask<CXDMealReview>
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
     @param body 
     
     return type: CXDMealReview
     */
    public func mealsMealIdReviewsReviewIdPut(reviewId: String, mealId: String, body: CXDMealReview) -> AWSTask<CXDMealReview> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["review_id"] = reviewId
	    pathParameters["meal_id"] = mealId
	    
	    return self.invokeHTTPRequest("PUT", urlString: "/meals/{mealId}/reviews/{reviewId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: body, responseClass: CXDMealReview.self) as! AWSTask<CXDMealReview>
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
     
     
     @param keyword 
     @param lat 
     @param sort 
     @param distance 
     @param page 
     @param long 
     
     return type: CXDArrayOfChef
     */
    public func searchChefsGet(keyword: String?, lat: String?, sort: String?, distance: String?, page: String?, long: String?) -> AWSTask<CXDArrayOfChef> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    var queryParameters:[String:Any] = [:]
	    queryParameters["keyword"] = keyword
	    queryParameters["lat"] = lat
	    queryParameters["sort"] = sort
	    queryParameters["distance"] = distance
	    queryParameters["page"] = page
	    queryParameters["long"] = long
	    
	    let pathParameters:[String:Any] = [:]
	    
	    return self.invokeHTTPRequest("GET", urlString: "/search/chefs", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDArrayOfChef.self) as! AWSTask<CXDArrayOfChef>
	}

	
    /*
     
     
     
     return type: 
     */
    public func searchChefsOptions() -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    let pathParameters:[String:Any] = [:]
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/search/chefs", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     @param keyword 
     @param lat 
     @param sort 
     @param distance 
     @param page 
     @param long 
     
     return type: CXDArrayOfMeal
     */
    public func searchMealsGet(keyword: String?, lat: String?, sort: String?, distance: String?, page: String?, long: String?) -> AWSTask<CXDArrayOfMeal> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    var queryParameters:[String:Any] = [:]
	    queryParameters["keyword"] = keyword
	    queryParameters["lat"] = lat
	    queryParameters["sort"] = sort
	    queryParameters["distance"] = distance
	    queryParameters["page"] = page
	    queryParameters["long"] = long
	    
	    let pathParameters:[String:Any] = [:]
	    
	    return self.invokeHTTPRequest("GET", urlString: "/search/meals", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDArrayOfMeal.self) as! AWSTask<CXDArrayOfMeal>
	}

	
    /*
     
     
     
     return type: 
     */
    public func searchMealsOptions() -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    let pathParameters:[String:Any] = [:]
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/search/meals", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     @param username 
     @param lat 
     @param sort 
     @param distance 
     @param page 
     @param long 
     
     return type: CXDArrayOfUser
     */
    public func usersGet(username: String?, lat: String?, sort: String?, distance: String?, page: String?, long: String?) -> AWSTask<CXDArrayOfUser> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    var queryParameters:[String:Any] = [:]
	    queryParameters["username"] = username
	    queryParameters["lat"] = lat
	    queryParameters["sort"] = sort
	    queryParameters["distance"] = distance
	    queryParameters["page"] = page
	    queryParameters["long"] = long
	    
	    let pathParameters:[String:Any] = [:]
	    
	    return self.invokeHTTPRequest("GET", urlString: "/users", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDArrayOfUser.self) as! AWSTask<CXDArrayOfUser>
	}

	
    /*
     
     
     @param body 
     
     return type: CXDUser
     */
    public func usersPost(body: CXDUser) -> AWSTask<CXDUser> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    let pathParameters:[String:Any] = [:]
	    
	    return self.invokeHTTPRequest("POST", urlString: "/users", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: body, responseClass: CXDUser.self) as! AWSTask<CXDUser>
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
     
     
     @param lat 
     @param sort 
     @param distance 
     @param page 
     @param long 
     
     return type: CXDArrayOfChef
     */
    public func usersChefsGet(lat: String?, sort: String?, distance: String?, page: String?, long: String?) -> AWSTask<CXDArrayOfChef> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    var queryParameters:[String:Any] = [:]
	    queryParameters["lat"] = lat
	    queryParameters["sort"] = sort
	    queryParameters["distance"] = distance
	    queryParameters["page"] = page
	    queryParameters["long"] = long
	    
	    let pathParameters:[String:Any] = [:]
	    
	    return self.invokeHTTPRequest("GET", urlString: "/users/chefs", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDArrayOfChef.self) as! AWSTask<CXDArrayOfChef>
	}

	
    /*
     
     
     
     return type: 
     */
    public func usersChefsOptions() -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    let pathParameters:[String:Any] = [:]
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/users/chefs", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     
     return type: CXDCurrentUser
     */
    public func usersCurrentuserGet() -> AWSTask<CXDCurrentUser> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    let pathParameters:[String:Any] = [:]
	    
	    return self.invokeHTTPRequest("GET", urlString: "/users/currentuser", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDCurrentUser.self) as! AWSTask<CXDCurrentUser>
	}

	
    /*
     
     
     @param body 
     
     return type: CXDCurrentUser
     */
    public func usersCurrentuserPut(body: CXDCurrentUser) -> AWSTask<CXDCurrentUser> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    let pathParameters:[String:Any] = [:]
	    
	    return self.invokeHTTPRequest("PUT", urlString: "/users/currentuser", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: body, responseClass: CXDCurrentUser.self) as! AWSTask<CXDCurrentUser>
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
     
     return type: CXDArrayOfBilling
     */
    public func usersCurrentuserBillingGet(userId: String) -> AWSTask<CXDArrayOfBilling> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("GET", urlString: "/users/currentuser/billing", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDArrayOfBilling.self) as! AWSTask<CXDArrayOfBilling>
	}

	
    /*
     
     
     @param userId 
     @param body 
     
     return type: CXDBilling
     */
    public func usersCurrentuserBillingPost(userId: String, body: CXDBilling) -> AWSTask<CXDBilling> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("POST", urlString: "/users/currentuser/billing", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: body, responseClass: CXDBilling.self) as! AWSTask<CXDBilling>
	}

	
    /*
     
     
     @param userId 
     
     return type: 
     */
    public func usersCurrentuserBillingOptions(userId: String) -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/users/currentuser/billing", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     @param billingId 
     @param userId 
     
     return type: CXDBilling
     */
    public func usersCurrentuserBillingBillingIdGet(billingId: String, userId: String) -> AWSTask<CXDBilling> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["billing_id"] = billingId
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("GET", urlString: "/users/currentuser/billing/{billingId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDBilling.self) as! AWSTask<CXDBilling>
	}

	
    /*
     
     
     @param billingId 
     @param userId 
     @param body 
     
     return type: CXDBilling
     */
    public func usersCurrentuserBillingBillingIdPut(billingId: String, userId: String, body: CXDBilling) -> AWSTask<CXDBilling> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["billing_id"] = billingId
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("PUT", urlString: "/users/currentuser/billing/{billingId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: body, responseClass: CXDBilling.self) as! AWSTask<CXDBilling>
	}

	
    /*
     
     
     @param billingId 
     @param userId 
     
     return type: 
     */
    public func usersCurrentuserBillingBillingIdOptions(billingId: String, userId: String) -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["billing_id"] = billingId
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/users/currentuser/billing/{billingId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     @param userId 
     @param sort 
     @param page 
     
     return type: CXDArrayOfDeliveryAddress
     */
    public func usersCurrentuserDeliveryAddressGet(userId: String, sort: String?, page: String?) -> AWSTask<CXDArrayOfDeliveryAddress> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    var queryParameters:[String:Any] = [:]
	    queryParameters["sort"] = sort
	    queryParameters["page"] = page
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("GET", urlString: "/users/currentuser/delivery_address", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDArrayOfDeliveryAddress.self) as! AWSTask<CXDArrayOfDeliveryAddress>
	}

	
    /*
     
     
     @param userId 
     @param body 
     
     return type: CXDDeliveryAddress
     */
    public func usersCurrentuserDeliveryAddressPost(userId: String, body: CXDDeliveryAddress) -> AWSTask<CXDDeliveryAddress> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("POST", urlString: "/users/currentuser/delivery_address", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: body, responseClass: CXDDeliveryAddress.self) as! AWSTask<CXDDeliveryAddress>
	}

	
    /*
     
     
     @param userId 
     
     return type: 
     */
    public func usersCurrentuserDeliveryAddressOptions(userId: String) -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/users/currentuser/delivery_address", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     @param deliveryAddressId 
     @param userId 
     
     return type: CXDDeliveryAddress
     */
    public func usersCurrentuserDeliveryAddressDeliveryAddressIdGet(deliveryAddressId: String, userId: String) -> AWSTask<CXDDeliveryAddress> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["delivery_address_id"] = deliveryAddressId
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("GET", urlString: "/users/currentuser/delivery_address/{deliveryAddressId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDDeliveryAddress.self) as! AWSTask<CXDDeliveryAddress>
	}

	
    /*
     
     
     @param deliveryAddressId 
     @param userId 
     @param body 
     
     return type: CXDDeliveryAddress
     */
    public func usersCurrentuserDeliveryAddressDeliveryAddressIdPut(deliveryAddressId: String, userId: String, body: CXDDeliveryAddress) -> AWSTask<CXDDeliveryAddress> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["delivery_address_id"] = deliveryAddressId
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("PUT", urlString: "/users/currentuser/delivery_address/{deliveryAddressId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: body, responseClass: CXDDeliveryAddress.self) as! AWSTask<CXDDeliveryAddress>
	}

	
    /*
     
     
     @param deliveryAddressId 
     @param userId 
     
     return type: CXDTransactionResult
     */
    public func usersCurrentuserDeliveryAddressDeliveryAddressIdDelete(deliveryAddressId: String, userId: String) -> AWSTask<CXDTransactionResult> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["delivery_address_id"] = deliveryAddressId
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("DELETE", urlString: "/users/currentuser/delivery_address/{deliveryAddressId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDTransactionResult.self) as! AWSTask<CXDTransactionResult>
	}

	
    /*
     
     
     @param deliveryAddressId 
     @param userId 
     
     return type: 
     */
    public func usersCurrentuserDeliveryAddressDeliveryAddressIdOptions(deliveryAddressId: String, userId: String) -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["delivery_address_id"] = deliveryAddressId
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/users/currentuser/delivery_address/{deliveryAddressId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     
     return type: CXDArrayOfUserPhoto
     */
    public func usersCurrentuserPhotosGet() -> AWSTask<CXDArrayOfUserPhoto> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    let pathParameters:[String:Any] = [:]
	    
	    return self.invokeHTTPRequest("GET", urlString: "/users/currentuser/photos", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDArrayOfUserPhoto.self) as! AWSTask<CXDArrayOfUserPhoto>
	}

	
    /*
     
     
     @param body 
     
     return type: CXDArrayOfUserPhoto
     */
    public func usersCurrentuserPhotosPost(body: CXDArrayOfUserPhoto) -> AWSTask<CXDArrayOfUserPhoto> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    let pathParameters:[String:Any] = [:]
	    
	    return self.invokeHTTPRequest("POST", urlString: "/users/currentuser/photos", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: body, responseClass: CXDArrayOfUserPhoto.self) as! AWSTask<CXDArrayOfUserPhoto>
	}

	
    /*
     
     
     
     return type: 
     */
    public func usersCurrentuserPhotosOptions() -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    let pathParameters:[String:Any] = [:]
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/users/currentuser/photos", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     @param photoId 
     
     return type: CXDUserPhoto
     */
    public func usersCurrentuserPhotosPhotoIdGet(photoId: String) -> AWSTask<CXDUserPhoto> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["photo_id"] = photoId
	    
	    return self.invokeHTTPRequest("GET", urlString: "/users/currentuser/photos/{photoId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDUserPhoto.self) as! AWSTask<CXDUserPhoto>
	}

	
    /*
     
     
     @param photoId 
     @param body 
     
     return type: CXDUserPhoto
     */
    public func usersCurrentuserPhotosPhotoIdPut(photoId: String, body: CXDUserPhoto) -> AWSTask<CXDUserPhoto> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["photo_id"] = photoId
	    
	    return self.invokeHTTPRequest("PUT", urlString: "/users/currentuser/photos/{photoId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: body, responseClass: CXDUserPhoto.self) as! AWSTask<CXDUserPhoto>
	}

	
    /*
     
     
     @param photoId 
     
     return type: CXDTransactionResult
     */
    public func usersCurrentuserPhotosPhotoIdDelete(photoId: String) -> AWSTask<CXDTransactionResult> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["photo_id"] = photoId
	    
	    return self.invokeHTTPRequest("DELETE", urlString: "/users/currentuser/photos/{photoId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDTransactionResult.self) as! AWSTask<CXDTransactionResult>
	}

	
    /*
     
     
     @param photoId 
     
     return type: 
     */
    public func usersCurrentuserPhotosPhotoIdOptions(photoId: String) -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["photo_id"] = photoId
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/users/currentuser/photos/{photoId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     @param userId 
     @param long 
     @param lat 
     
     return type: CXDUser
     */
    public func usersUserIdGet(userId: String, long: String?, lat: String?) -> AWSTask<CXDUser> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    var queryParameters:[String:Any] = [:]
	    queryParameters["long"] = long
	    queryParameters["lat"] = lat
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("GET", urlString: "/users/{userId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDUser.self) as! AWSTask<CXDUser>
	}

	
    /*
     
     
     @param userId 
     @param body 
     
     return type: CXDUser
     */
    public func usersUserIdPut(userId: String, body: CXDUser) -> AWSTask<CXDUser> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("PUT", urlString: "/users/{userId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: body, responseClass: CXDUser.self) as! AWSTask<CXDUser>
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
     
     return type: CXDCart
     */
    public func usersUserIdCartGet(userId: String) -> AWSTask<CXDCart> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("GET", urlString: "/users/{userId}/cart", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDCart.self) as! AWSTask<CXDCart>
	}

	
    /*
     
     
     @param userId 
     @param body 
     
     return type: CXDCartItem
     */
    public func usersUserIdCartPost(userId: String, body: CXDCartItem) -> AWSTask<CXDCartItem> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("POST", urlString: "/users/{userId}/cart", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: body, responseClass: CXDCartItem.self) as! AWSTask<CXDCartItem>
	}

	
    /*
     
     
     @param userId 
     
     return type: 
     */
    public func usersUserIdCartOptions(userId: String) -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/users/{userId}/cart", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     @param userId 
     @param cartItemId 
     
     return type: CXDCartItem
     */
    public func usersUserIdCartCartItemIdGet(userId: String, cartItemId: String) -> AWSTask<CXDCartItem> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    pathParameters["cart_item_id"] = cartItemId
	    
	    return self.invokeHTTPRequest("GET", urlString: "/users/{userId}/cart/{cartItemId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDCartItem.self) as! AWSTask<CXDCartItem>
	}

	
    /*
     
     
     @param userId 
     @param cartItemId 
     @param body 
     
     return type: CXDCartItem
     */
    public func usersUserIdCartCartItemIdPut(userId: String, cartItemId: String, body: CXDCartItem) -> AWSTask<CXDCartItem> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    pathParameters["cart_item_id"] = cartItemId
	    
	    return self.invokeHTTPRequest("PUT", urlString: "/users/{userId}/cart/{cartItemId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: body, responseClass: CXDCartItem.self) as! AWSTask<CXDCartItem>
	}

	
    /*
     
     
     @param userId 
     @param cartItemId 
     
     return type: CXDTransactionResult
     */
    public func usersUserIdCartCartItemIdDelete(userId: String, cartItemId: String) -> AWSTask<CXDTransactionResult> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    pathParameters["cart_item_id"] = cartItemId
	    
	    return self.invokeHTTPRequest("DELETE", urlString: "/users/{userId}/cart/{cartItemId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDTransactionResult.self) as! AWSTask<CXDTransactionResult>
	}

	
    /*
     
     
     @param userId 
     @param cartItemId 
     
     return type: 
     */
    public func usersUserIdCartCartItemIdOptions(userId: String, cartItemId: String) -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    pathParameters["cart_item_id"] = cartItemId
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/users/{userId}/cart/{cartItemId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     @param userId 
     @param sort 
     @param page 
     
     return type: CXDArrayOfMeal
     */
    public func usersUserIdFavoritemealsGet(userId: String, sort: String?, page: String?) -> AWSTask<CXDArrayOfMeal> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    var queryParameters:[String:Any] = [:]
	    queryParameters["sort"] = sort
	    queryParameters["page"] = page
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("GET", urlString: "/users/{userId}/favoritemeals", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDArrayOfMeal.self) as! AWSTask<CXDArrayOfMeal>
	}

	
    /*
     
     
     @param userId 
     @param body 
     
     return type: CXDFavoriteMeal
     */
    public func usersUserIdFavoritemealsPost(userId: String, body: CXDMeal) -> AWSTask<CXDFavoriteMeal> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("POST", urlString: "/users/{userId}/favoritemeals", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: body, responseClass: CXDFavoriteMeal.self) as! AWSTask<CXDFavoriteMeal>
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
     
     
     @param mealId 
     @param userId 
     
     return type: CXDTransactionResult
     */
    public func usersUserIdFavoritemealsMealIdDelete(mealId: String, userId: String) -> AWSTask<CXDTransactionResult> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["meal_id"] = mealId
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("DELETE", urlString: "/users/{userId}/favoritemeals/{mealId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDTransactionResult.self) as! AWSTask<CXDTransactionResult>
	}

	
    /*
     
     
     @param mealId 
     @param userId 
     
     return type: 
     */
    public func usersUserIdFavoritemealsMealIdOptions(mealId: String, userId: String) -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["meal_id"] = mealId
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/users/{userId}/favoritemeals/{mealId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     @param userId 
     @param sort 
     @param page 
     
     return type: CXDArrayOfMenu
     */
    public func usersUserIdMenuGet(userId: String, sort: String?, page: String?) -> AWSTask<CXDArrayOfMenu> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    var queryParameters:[String:Any] = [:]
	    queryParameters["sort"] = sort
	    queryParameters["page"] = page
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("GET", urlString: "/users/{userId}/menu", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDArrayOfMenu.self) as! AWSTask<CXDArrayOfMenu>
	}

	
    /*
     
     
     @param userId 
     
     return type: CXDMenu
     */
    public func usersUserIdMenuPost(userId: String) -> AWSTask<CXDMenu> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("POST", urlString: "/users/{userId}/menu", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDMenu.self) as! AWSTask<CXDMenu>
	}

	
    /*
     
     
     @param userId 
     
     return type: 
     */
    public func usersUserIdMenuOptions(userId: String) -> AWSTask<AnyObject> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("OPTIONS", urlString: "/users/{userId}/menu", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: nil)
	}

	
    /*
     
     
     @param userId 
     @param sort 
     @param page 
     
     return type: CXDArrayOfOrder
     */
    public func usersUserIdOrdersGet(userId: String, sort: String?, page: String?) -> AWSTask<CXDArrayOfOrder> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    var queryParameters:[String:Any] = [:]
	    queryParameters["sort"] = sort
	    queryParameters["page"] = page
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("GET", urlString: "/users/{userId}/orders", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDArrayOfOrder.self) as! AWSTask<CXDArrayOfOrder>
	}

	
    /*
     
     
     @param userId 
     @param body 
     
     return type: CXDOrder
     */
    public func usersUserIdOrdersPost(userId: String, body: CXDOrder) -> AWSTask<CXDOrder> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("POST", urlString: "/users/{userId}/orders", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: body, responseClass: CXDOrder.self) as! AWSTask<CXDOrder>
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
     
     return type: CXDOrder
     */
    public func usersUserIdOrdersOrderIdGet(userId: String, orderId: String) -> AWSTask<CXDOrder> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    pathParameters["order_id"] = orderId
	    
	    return self.invokeHTTPRequest("GET", urlString: "/users/{userId}/orders/{orderId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDOrder.self) as! AWSTask<CXDOrder>
	}

	
    /*
     
     
     @param userId 
     @param orderId 
     @param body 
     
     return type: CXDOrder
     */
    public func usersUserIdOrdersOrderIdPut(userId: String, orderId: String, body: CXDOrder) -> AWSTask<CXDOrder> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    pathParameters["order_id"] = orderId
	    
	    return self.invokeHTTPRequest("PUT", urlString: "/users/{userId}/orders/{orderId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: body, responseClass: CXDOrder.self) as! AWSTask<CXDOrder>
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
     @param page 
     
     return type: CXDArrayOfUserReview
     */
    public func usersUserIdReviewsGet(userId: String, page: String?) -> AWSTask<CXDArrayOfUserReview> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    var queryParameters:[String:Any] = [:]
	    queryParameters["page"] = page
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("GET", urlString: "/users/{userId}/reviews", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDArrayOfUserReview.self) as! AWSTask<CXDArrayOfUserReview>
	}

	
    /*
     
     
     @param userId 
     @param body 
     
     return type: CXDUserReview
     */
    public func usersUserIdReviewsPost(userId: String, body: CXDUserReview) -> AWSTask<CXDUserReview> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("POST", urlString: "/users/{userId}/reviews", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: body, responseClass: CXDUserReview.self) as! AWSTask<CXDUserReview>
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
     @param body 
     
     return type: CXDUserReview
     */
    public func usersUserIdReviewsReviewIdPut(reviewId: String, userId: String, body: CXDUserReview) -> AWSTask<CXDUserReview> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["review_id"] = reviewId
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("PUT", urlString: "/users/{userId}/reviews/{reviewId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: body, responseClass: CXDUserReview.self) as! AWSTask<CXDUserReview>
	}

	
    /*
     
     
     @param reviewId 
     @param userId 
     
     return type: CXDTransactionResult
     */
    public func usersUserIdReviewsReviewIdDelete(reviewId: String, userId: String) -> AWSTask<CXDTransactionResult> {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   
	            ]
	    
	    let queryParameters:[String:Any] = [:]
	    
	    var pathParameters:[String:Any] = [:]
	    pathParameters["review_id"] = reviewId
	    pathParameters["user_id"] = userId
	    
	    return self.invokeHTTPRequest("DELETE", urlString: "/users/{userId}/reviews/{reviewId}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: CXDTransactionResult.self) as! AWSTask<CXDTransactionResult>
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
