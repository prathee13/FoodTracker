//
//  ViewController.swift
//  FoodTracker
//
//  Created by Pratheeksha Ravindra Naik on 2018-09-22.
//  Copyright © 2018 com/uregina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Properties

    @IBOutlet weak var nameTextField: UITextField!   //Linking text-field to code
    
    @IBOutlet weak var mealNameLabel: UILabel!  //Connecting Label to code
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    //MARK: Actions
    
    @IBAction func setDefaultLabeltext(_ sender: UIButton) {
        mealNameLabel.text = "Default Text"
    }
    
   
    
}

