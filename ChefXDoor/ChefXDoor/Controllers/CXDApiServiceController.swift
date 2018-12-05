//
//  CXDApiServiceController.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 8/24/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import AWSAPIGateway
import AWSCore

class CXDApiServiceController{
    
    var client:CXDAWSApiClient
    
    static let sharedController = CXDApiServiceController()
    
    private init() {
        client = CXDAWSApiClient.client(forKey: "USEast1CXDDEVAPIClient")
        client.apiKey = CXDAWSApiKey
    }
    
    public class func awsGetFromEndPoint(urlString:String, queryParametersDict:[String:Any]?, pathParametersDict:[String:Any]?, classType:AnyClass) -> AWSTask<AnyObject>
    {
        let headerParameters = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            ]
        
        var queryParameters:[String:Any] = [:]
        if var _ = queryParametersDict
        {
            queryParameters = queryParametersDict!
        }
        
        var pathParameters:[String:Any] = [:]
        if var _ = pathParametersDict
        {
            pathParameters = pathParametersDict!
        }
       return sharedController.client.invokeHTTPRequest("GET", urlString: urlString, pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: classType)
    }
}
