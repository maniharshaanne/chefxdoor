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
 

import Foundation
import AWSCore

@objcMembers
public class CXDChef : AWSModel {
    
    /** description */
    var id: NSNumber?
    /** description */
    var username: String?
    /** description */
    var imageUrl: String?
    /** description */
    var deliveryFee: NSNumber?
    /** description */
    var slogan: String?
    /** descriptionn */
    var categories: String?
    /** description */
    var reviewCount: NSNumber?
    /** description */
    var rating: NSNumber?
    /** description */
    var distance: NSNumber?
    /** description */
    var timeModified: String?
    /** description */
    var timeCreated: String?
    
   	public override static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]!{
		var params:[AnyHashable : Any] = [:]
		params["id"] = "id"
		params["username"] = "username"
		params["imageUrl"] = "image_url"
		params["deliveryFee"] = "delivery_fee"
		params["slogan"] = "slogan"
		params["categories"] = "categories"
		params["reviewCount"] = "review_count"
		params["rating"] = "rating"
		params["distance"] = "distance"
		params["timeModified"] = "time_modified"
		params["timeCreated"] = "time_created"
		
        return params
	}
}
