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
        var rating = 0;

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
        print("Button pressed! ")
    }
    
    /*
 ERROR HERE - Expected Declatarion 
     clear any existing buttons
    for buttons in ratingButtons {
     removeArrangedSubview(buttons)
    buttons.removeFromSuperview()
    }
    
    ratingButtons.removeAll()
    */
    
    //MARK: Private methods
    
    private func setupButtons() {
    
    for _ in 0..<starCount {
        
        //create the button
        let button = UIButton();
        button.backgroundColor = UIColor.red;
        
        //constraints - making it a fixed size object
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true;
        button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true;
        
        //setup the button action
        button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
        
        //adding button to stack
        addArrangedSubview(button);
        
        //add the new button to the rating button array
        ratingButtons.append(button)
        
    }
}

}
