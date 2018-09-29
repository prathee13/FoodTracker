//
//  Meal.swift
//  FoodTracker
//
//  Created by Pratheeksha Ravindra Naik on 2018-09-24.
//  Copyright © 2018 com/uregina. All rights reserved.
//

import os.log
import UIKit

public class Meal: NSObject, NSCoding {
    
    //MARK: Types
    
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
        
    }
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    
    //MARK: initializers

    //initialization should fail if there is no name or if the rating is negative.
   
    
    init?(name: String, photo: UIImage?, rating: Int) {
        
        //the name must not be empty - we
        guard !name.isEmpty else {
            return nil
        }
        
       //The rating should be between 0 and 5
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        //initialize stored properties
        self.name = name
        self.photo = photo
        self.rating = rating
        
    }
    //MARK: NSCoding
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
        
        //Because photo is an optional property of Meal, we use conditional cast
        
        
        let rating = aDecoder.decodeIntegerForKey(PropertyKey.rating)
        
        //Must call designated initializer.
        self.init(name: name, photo: photo, rating: rating)
    }
    
     required convenience init?(coder aDecoder: NSCoder) {
        //The name is required. if we cannot decode a name string, the initializer should fail.
        
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
        else
        {
            os_log("Unable to decode the name of the meal object.", log: OSLog.default, type: .debug)
        }
        return nil
    }
    
    //because
    
}
