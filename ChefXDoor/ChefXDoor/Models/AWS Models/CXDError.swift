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
public class CXDError : AWSModel {
    
    var error: [String:AnyObject]?
    
   	public override static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]!{
		var params:[AnyHashable : Any] = [:]
		params["error"] = "Error"
		
        return params
	}
	class func errorJSONTransformer() -> ValueTransformer{
		return AWSMTLValueTransformer.reversibleTransformer(forwardBlock: {(JSONDictionary: Any!) -> Any! in
            return AWSModelUtility.mapMTLDictionary(fromJSONDictionary: JSONDictionary as! [AnyHashable : Any], withModelClass: AnyObject.self)
		}, reverse: {(mapMTLDictionary: Any!) -> Any! in
            return AWSModelUtility.jsonDictionary(fromMapMTLDictionary: mapMTLDictionary as! [AnyHashable : Any])
		})
	}
}
