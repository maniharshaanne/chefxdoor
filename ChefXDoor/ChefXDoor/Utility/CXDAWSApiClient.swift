//
//  CXDAWSApiClient.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 9/4/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import Foundation
import AWSCore
import AWSAPIGateway

public class CXDAWSApiClient: AWSAPIGatewayClient{
 
    static let AWSInfoClientKey = "CXDDEVAPIClient"
    
    private static let _serviceClients = AWSSynchronizedMutableDictionary()

    public class func registerClient(withConfiguration configuration: AWSServiceConfiguration, forKey key: String){
        _serviceClients.setObject(CXDAWSApiClient(configuration: configuration), forKey: key  as NSString);
    }
    
    public class func client(forKey key: String) -> CXDAWSApiClient {
        objc_sync_enter(self)
        if let client: CXDAWSApiClient = _serviceClients.object(forKey: key) as? CXDAWSApiClient {
            objc_sync_exit(self)
            return client
        }
        
        let serviceInfo = AWSInfo.default().defaultServiceInfo(AWSInfoClientKey)
        if let serviceInfo = serviceInfo {
            let serviceConfiguration = AWSServiceConfiguration(region: serviceInfo.region, credentialsProvider: serviceInfo.cognitoCredentialsProvider)
            CXDAWSApiClient.registerClient(withConfiguration: serviceConfiguration!, forKey: key)
        }
        objc_sync_exit(self)
        return _serviceClients.object(forKey: key) as! CXDAWSApiClient;
    }
    
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
    
}
