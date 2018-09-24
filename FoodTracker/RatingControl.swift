//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Pratheeksha Ravindra Naik on 2018-09-22.
//  Copyright © 2018 com/uregina. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView { 
    
    //MARK: Properties
    private var ratingButtons = [UIButton]()
    
    //intial value and if at all rating changes later
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0){
        didSet {
            setupButtons()
        }
    }
    
    
    @IBInspectable var starCount: Int = 5 {
        didSet{
            setupButtons()
        }
    }
    

    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame);
        setupButtons();
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons();
    }
    
    //MARK: Button Action
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
    
    private func setupButtons() {
        
        //clearing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        //Loading the stars from assets catalogue
        
        let bundle = Bundle(for: type(of: self))
        
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
    
        
    for index in 0..<starCount {
        
        //create the button
        let button = UIButton();
        
         //setting the button images
        button.setImage(emptyStar, for: .normal)
        button.setImage(filledStar, for: .selected)
        button.setImage(highlightedStar, for: .highlighted)
        button.setImage(highlightedStar, for: [.highlighted, .selected])
        
        
        //constraints - making it a fixed size object
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true;
        button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true;
        
        //accessability label
        button.accessibilityLabel = "Set \(index+1) star rating"
        
        //setup the button action
        button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
        
        //adding button to stack
        addArrangedSubview(button);
        
        //add the new button to the rating button array
        ratingButtons.append(button);
        
    }
        updateButtonSelectionStates()
}

    //method to update selection state of the buttons
    
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
            
            //Assigning
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
    
    
}
