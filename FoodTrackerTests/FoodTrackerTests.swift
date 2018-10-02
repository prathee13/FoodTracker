//
//  @Name: FoodTrackerTests.swift
//  @Purpose: Tests the App
//
// FoodTrackerTests
//
//  Created by Pratheeksha Ravindra Naik on 2018-09-22.
//  Copyright © 2018 com/uregina. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
    //MARK: Meal Class tests
    
    //Confirm that the Meal Initializer returns a Meal object when passed valid parameters
    
    //Function that describes positive Test Cases
    
    func testMealInitializationSucceeds() {
        //Zero rating
        let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal)
        
        //Highest Rating
        let positiveRatingMeal = Meal.init(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRatingMeal)
        
    }
    
    //Function that test negative cases
    func testMealInitializationFails() {
        //Negative rating
        let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)
        
        //Empty String
        let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyStringMeal)
        
        //Rating Exceeds Maximum
        let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6)
        XCTAssertNil(largeRatingMeal)
    }
    
}
