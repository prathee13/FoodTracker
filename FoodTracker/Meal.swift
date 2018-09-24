//
//  Meal.swift
//  FoodTracker
//
//  Created by Pratheeksha Ravindra Naik on 2018-09-24.
//  Copyright © 2018 com/uregina. All rights reserved.
//

import UIKit

public class Meal {
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    
    //MARK: initializers

    //initialization should fail if there is no name or if the rating is negative.
   
    
    init?(name: String, photo: UIImage?, rating: Int) {
        
        //the name must not be empty
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

}
