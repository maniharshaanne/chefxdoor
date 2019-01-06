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


import Foundation
import AWSCore


@objcMembers
public class CXDDeliveryAddress : AWSModel {
    
    /** description */
    var id: NSNumber?
    /** description */
    var userId: NSNumber?
    /** description */
    var name: String?
    /** description */
    var street: String?
    /** description */
    var city: String?
    /** description */
    var state: String?
    /** description */
    var zip: NSNumber?
    /** description */
    var isMainAddress: NSNumber?
    /** description */
    var timeCreated: String?
    /** description */
    var timeModified: String?
    
   	public override static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]!{
		var params:[AnyHashable : Any] = [:]
		params["id"] = "id"
		params["userId"] = "user_id"
		params["name"] = "name"
		params["street"] = "street"
		params["city"] = "city"
		params["state"] = "state"
		params["zip"] = "zip"
		params["isMainAddress"] = "is_main_address"
		params["timeCreated"] = "time_created"
		params["timeModified"] = "time_modified"
		
        return params
	}
}
