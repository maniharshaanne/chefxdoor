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
public class CXDUser : AWSModel {
    
    /** description */
    var id: NSNumber?
    /** description */
    var providerName: String?
    /** description */
    var username: String?
    /** description */
    var preferredUsername: String?
    /** description */
    var email: String?
    /** description */
    var type: String?
    /** description */
    var slogan: String?
    /** description */
    var introduction: String?
    /** description */
    var _description: String?
    /** description */
    var firstname: String?
    /** description */
    var lastname: String?
    /** description */
    var street: String?
    /** description */
    var city: String?
    /** description */
    var state: String?
    /** description */
    var zipcode: NSNumber?
    /** description */
    var phone: String?
    /** description */
    var gender: String?
    /** description */
    var ethnicity: String?
    /** description */
    var currentLatitude: NSNumber?
    /** description */
    var currentLongitude: NSNumber?
    /** description */
    var rating: NSNumber?
    /** description */
    var ratingCount: NSNumber?
    /** description */
    var status: String?
    /** description */
    var birthday: String?
    /** description */
    var imageUrl: String?
    /** description */
    var imageId: String?
    /** description */
    var timeCreated: String?
    /** description */
    var timeModified: String?
    /** description */
    var distance: NSNumber?
    /** Url for user cover photo */
    var coverPhotoUrl: String?
    /** top three categories for user by aggregate rating */
    var topCategories: String?
    /** boolean */
    var allowsPickup: NSNumber?
    var photos: [CXDUserPhoto]?
    var foodRestrictions: [CXDFoodRestriction]?
    
   	public override static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]!{
		var params:[AnyHashable : Any] = [:]
		params["id"] = "id"
		params["providerName"] = "provider_name"
		params["username"] = "username"
		params["preferredUsername"] = "preferred_username"
		params["email"] = "email"
		params["type"] = "type"
		params["slogan"] = "slogan"
		params["introduction"] = "introduction"
		params["_description"] = "description"
		params["firstname"] = "firstname"
		params["lastname"] = "lastname"
		params["street"] = "street"
		params["city"] = "city"
		params["state"] = "state"
		params["zipcode"] = "zipcode"
		params["phone"] = "phone"
		params["gender"] = "gender"
		params["ethnicity"] = "ethnicity"
		params["currentLatitude"] = "current_latitude"
		params["currentLongitude"] = "current_longitude"
		params["rating"] = "rating"
		params["ratingCount"] = "rating_count"
		params["status"] = "status"
		params["birthday"] = "birthday"
		params["imageUrl"] = "image_url"
		params["imageId"] = "image_id"
		params["timeCreated"] = "time_created"
		params["timeModified"] = "time_modified"
		params["distance"] = "distance"
		params["coverPhotoUrl"] = "cover_photo_url"
		params["topCategories"] = "top_categories"
		params["allowsPickup"] = "allows_pickup"
		params["photos"] = "photos"
		params["foodRestrictions"] = "food_restrictions"
		
        return params
	}
	class func photosJSONTransformer() -> ValueTransformer{
		return  ValueTransformer.awsmtl_JSONArrayTransformer(withModelClass: CXDUserPhoto.self);
	}
	class func foodRestrictionsJSONTransformer() -> ValueTransformer{
		return  ValueTransformer.awsmtl_JSONArrayTransformer(withModelClass: CXDFoodRestriction.self);
	}
}
