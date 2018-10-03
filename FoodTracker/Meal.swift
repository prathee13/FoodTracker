//
//  @Name: Meal.swift
//  @Purpose: To update the data models.
//FoodTracker
//
//  Created by Pratheeksha Ravindra Naik on 2018-09-24.
//  Copyright © 2018 com/uregina. All rights reserved.
//

import os.log
import UIKit
/*
 
 A class that includes all the Meal items such as the name, photo and rating with an initialization method
 
 */

class Meal: NSObject, NSCoding {
    
    //MARK: Types
    
    struct PropertyKey {
        //Each constant corresponds to one of the three properties of Meal
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("Meals")
    
    //MARK: initializers

    /*
     
     Funtion to initialize the properties declared above. But prior to initialization, it checks if no name is specified or if the rating is negative or greater than 5, under which the initalization fails.
     
     
    */
   
    
    init?(name: String, photo: UIImage?, rating: Int) {
        
        //the name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
       //The rating should be between 0 and 5 - nothing less, nothing more.
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        //initialize stored properties
        self.name = name
        self.photo = photo
        self.rating = rating
        
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        //The name is required. If we cannot decode a name string, the initializer should fail.
        
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
        else
        {
            os_log("Unable to decode the name of the Meal object.", log: OSLog.default, type: .debug)
        
        return nil
    }
        //As photo is an optional property of Meal, we use conditional casting
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        //Must call designated initializer
        self.init(name: name, photo: photo, rating: rating)
    }
    
    
}
