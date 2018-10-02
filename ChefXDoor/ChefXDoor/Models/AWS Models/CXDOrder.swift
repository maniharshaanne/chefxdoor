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
public class CXDOrder : AWSModel {
    
    /** description */
    var id: NSNumber?
    /** description */
    var userId: NSNumber?
    /** description */
    var billingId: NSNumber?
    var driverId: NSNumber?
    var deliveryAddressId: NSNumber?
    var tip: NSNumber?
    var taxes: NSNumber?
    var promotion: NSNumber?
    /** description */
    var deliveryFee: NSNumber?
    /** description */
    var orderNumber: NSNumber?
    /** description */
    var note: String?
    /** description */
    var orderStatusId: NSNumber?
    /** description */
    var status: String?
    var deliveryAddress: CXDDeliveryAddress?
    var orderItems: [CXDOrderItem]?
    /** description */
    var timeCreated: String?
    /** description */
    var timeModified: String?
    
   	public override static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]!{
		var params:[AnyHashable : Any] = [:]
		params["id"] = "id"
		params["userId"] = "user_id"
		params["billingId"] = "billing_id"
		params["driverId"] = "driver_id"
		params["deliveryAddressId"] = "delivery_address_id"
		params["tip"] = "tip"
		params["taxes"] = "taxes"
		params["promotion"] = "promotion"
		params["deliveryFee"] = "delivery_fee"
		params["orderNumber"] = "order_number"
		params["note"] = "note"
		params["orderStatusId"] = "order_status_id"
		params["status"] = "status"
		params["deliveryAddress"] = "delivery_address"
		params["orderItems"] = "order_items"
		params["timeCreated"] = "time_created"
		params["timeModified"] = "time_modified"
		
        return params
	}
	class func deliveryAddressJSONTransformer() -> ValueTransformer{
	    return ValueTransformer.awsmtl_JSONDictionaryTransformer(withModelClass: CXDDeliveryAddress.self);
	}
	class func orderItemsJSONTransformer() -> ValueTransformer{
		return  ValueTransformer.awsmtl_JSONArrayTransformer(withModelClass: CXDOrderItem.self);
	}
}
