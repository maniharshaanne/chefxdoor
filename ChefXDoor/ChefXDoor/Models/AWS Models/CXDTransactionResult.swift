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
public class CXDTransactionResult : AWSModel {
    
    /** fieldCount */
    var fieldCount: NSNumber?
    /** affectedRows */
    var affectedRows: NSNumber?
    /** The id. */
    var insertId: NSNumber?
    /** serverStatus */
    var serverStatus: String?
    /** warningCount */
    var warningCount: NSNumber?
    /** message */
    var message: String?
    /** protocol41 */
    var protocol41: String?
    /** changedRows */
    var changedRows: NSNumber?
    /** success message */
    var success: String?
    
   	public override static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]!{
		var params:[AnyHashable : Any] = [:]
		params["fieldCount"] = "fieldCount"
		params["affectedRows"] = "affectedRows"
		params["insertId"] = "insertId"
		params["serverStatus"] = "serverStatus"
		params["warningCount"] = "warningCount"
		params["message"] = "message"
		params["protocol41"] = "protocol41"
		params["changedRows"] = "changedRows"
		params["success"] = "success"
		
        return params
	}
}
