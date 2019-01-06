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
public class CXDMeal : AWSModel {
    
    /** description */
    var id: NSNumber?
    /** description */
    var chefId: NSNumber?
    /** description */
    var name: String?
    /** description */
    var price: NSNumber?
    /** description */
    var deliveryFee: NSNumber?
    /** description */
    var _description: String?
    /** description */
    var availableQuantity: NSNumber?
    /** description */
    var ingredients: String?
    /** description */
    var timeCreated: String?
    /** description */
    var timeModified: String?
    /** description */
    var imageUrl: String?
    /** description */
    var chefUsername: String?
    /** description */
    var chefImageUrl: String?
    /** description */
    var rating: NSNumber?
    /** description */
    var liked: NSNumber?
    /** description */
    var reviewCount: NSNumber?
    /** boolean */
    var isActive: NSNumber?
    /** description */
    var distance: NSNumber?
    /** boolean */
    var allowsPickup: NSNumber?
    var photos: [CXDMealPhoto]?
    var categories: [CXDMealCategory]?
    var restrictions: [CXDFoodClassification]?
    
   	public override static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]!{
		var params:[AnyHashable : Any] = [:]
		params["id"] = "id"
		params["chefId"] = "chef_id"
		params["name"] = "name"
		params["price"] = "price"
		params["deliveryFee"] = "delivery_fee"
		params["_description"] = "description"
		params["availableQuantity"] = "available_quantity"
		params["ingredients"] = "ingredients"
		params["timeCreated"] = "time_created"
		params["timeModified"] = "time_modified"
		params["imageUrl"] = "image_url"
		params["chefUsername"] = "chef_username"
		params["chefImageUrl"] = "chef_image_url"
		params["rating"] = "rating"
		params["liked"] = "liked"
		params["reviewCount"] = "review_count"
		params["isActive"] = "is_active"
		params["distance"] = "distance"
		params["allowsPickup"] = "allows_pickup"
		params["photos"] = "photos"
		params["categories"] = "categories"
		params["restrictions"] = "restrictions"
		
        return params
	}
	class func photosJSONTransformer() -> ValueTransformer{
		return  ValueTransformer.awsmtl_JSONArrayTransformer(withModelClass: CXDMealPhoto.self);
	}
	class func categoriesJSONTransformer() -> ValueTransformer{
		return  ValueTransformer.awsmtl_JSONArrayTransformer(withModelClass: CXDMealCategory.self);
	}
	class func restrictionsJSONTransformer() -> ValueTransformer{
		return  ValueTransformer.awsmtl_JSONArrayTransformer(withModelClass: CXDFoodClassification.self);
	}
}
