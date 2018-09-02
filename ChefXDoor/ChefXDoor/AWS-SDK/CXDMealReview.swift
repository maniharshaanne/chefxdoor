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

 
public class CXDMealReview : AWSModel {
    
    /** description */
    var id: NSNumber?
    /** description */
    var mealId: NSNumber?
    /** description */
    var userId: NSNumber?
    /** description */
    var title: String?
    /** description */
    var message: String?
    /** description */
    var timeCreated: String?
    /** description */
    var timeModified: String?
    
   	public override static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]!{
		var params:[AnyHashable : Any] = [:]
		params["id"] = "id"
		params["mealId"] = "meal_id"
		params["userId"] = "user_id"
		params["title"] = "title"
		params["message"] = "message"
		params["timeCreated"] = "time_created"
		params["timeModified"] = "time_modified"
		
        return params
	}
}
