//
//  @Name: RatingControl.swift
//  @Purpose: To control the rating of the stars and update the views of the
//  buttons - before, after and while they are pressed.
//  FoodTracker
//
//  Created by Pratheeksha Ravindra Naik on 2018-09-22.
//  Copyright © 2018 com/uregina. All rights reserved.
//

import UIKit

/*

 Class to control the Rating. Inherits UItackView
 Includes Data
 */

@IBDesignable class RatingControl: UIStackView { 
    
    //MARK: Properties
    private var ratingButtons = [UIButton]()   //Variable indicating the list of buttons
    
 
    var rating = 0 {                           //Variable to control the user's rating
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    //Variables to define the size of the buttons - height and weight, and to set up accordingly.
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0){
        didSet {
            setupButtons()
        }
    }
    //Variables to control the count of the buttons i.e 5 in our case.
    @IBInspectable var starCount: Int = 5 {
        didSet{
            setupButtons()
        }
    }
    

    //MARK: Initialization
    
    /*
     Initializers are place-holders which call the superclass' implementation
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setupButtons();
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons();
    }
    
    //MARK: Button Action
    
    /*
     
     Function to calculate the rating as per the input from the user.
     
     Parameter: Accepts UIButton object to recognize the touch.
     
    */
    
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        //calculate the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            //if selected star is the current rating, reset the rating to 0
              rating = 0
            
        } else {
            //set rating to the selected star
            rating = selectedRating
        }
    }
    
  
    
    //MARK: Private methods
    
    /*
    
     Function to set up the buttons below the image to faciliate the user to rate a food item.
     Calls updateButtonelectionStates() to indicate the changes when the user rates it.
     
 
    */
    
    
    private func setupButtons() {
        
        //clearing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        ratingButtons.removeAll()
        
        //Loading the image (i.e. the stars) from assets catalogue to set the appropriate image to the right code
        
        let bundle = Bundle(for: type(of: self))
        
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
    
        
    for index in 0..<starCount {
        
        //create the button
        let button = UIButton();
        
        //Buttons have different states and can even be in two different states at the same time.
        button.setImage(emptyStar, for: .normal)                           //Empty star for default state.
        button.setImage(filledStar, for: .selected)                        //Filled when user just taps it
        button.setImage(highlightedStar, for: .highlighted)                //On tapping it remains in 'highlight' stage
        button.setImage(highlightedStar, for: [.highlighted, .selected])
        
        
        //Constraints for making the buttons a fixed size object
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true;
        button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true;
        
        //Accessability Label - a phrase that describes the control or view
        button.accessibilityLabel = "Set \(index+1) star rating"
        
        //Setting up the button action
        button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
        
        //Adding the button to stack
        addArrangedSubview(button);
        
        //Adding the new button to the rating button array
        ratingButtons.append(button);
        
    }
        updateButtonSelectionStates()
}

    /*
       Function to update the states of the button as the rating variable is updated and the position upto where the user has tapped.
     
       Is called by the setupButtons() method.
    */
    
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            //if the index of a button is less than the rating, that button should be selected
                button.isSelected = index < rating
            
            let hintString: String?
            
            if rating == index + 1 {
                hintString = "tap to reset the rating to zero"
                
            } else {
                hintString = nil
            }
            
            //calculate the hint and value string
            let valueString: String
            switch(rating) {
            case 0:
                valueString = "no rating"
            case 1:
                valueString = "1 star set"
            default:
                valueString = "\(rating) stars set"
            }
            
            //Assigning accessibility value and hint. The former is the current value of an element and the latter is the phrase that reminds the result of the action.
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
    
    
}
