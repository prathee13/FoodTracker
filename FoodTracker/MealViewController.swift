//
// @Name: MealViewController.swift
// @Purpose: C
//  FoodTracker
//
//  Created by Pratheeksha Ravindra Naik on 2018-09-22.
//  Modified by Pratheeksha Ravindra Naik on 2018-09-28
//  Copyright © 2018 com/uregina. All rights reserved.
//

import os.log //To import unified logging system
import UIKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Acts as valid text deligate and to adopt picker and controller delegates
    
    //MARK: Properties

    @IBOutlet weak var nameTextField: UITextField!   //Creating an outlet for text-field
    
    
    @IBOutlet weak var photoImageView: UIImageView!  //Creating an outlet for the image
    
    
    @IBOutlet weak var ratingControl: RatingControl!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
/* This value is either passed by 'MealTableViewController' in 'prepare(for: sender:)'
 or constructed as part of adding a new meal */
    
    var meal: Meal?
    
    //Function that is called when view controller's view is loaded from the storyboard
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //Handle the text field's user input through delegate callbacks.
        
        nameTextField.delegate = self  //Refers to ViewControllerClass
        
        //Set up views if editing an existing Meal
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        
        //Enable the save button only if tje text field has a valid Meal Name
        updateSaveButtonState()
    }

    //MARK: UITextFieldDelegate
    
    /*
     
     Function to specify what the text editor must do when the user taps a button to end the editing.
     It hides the keyboard and accepts a text field parameter.
     Returns either 'true' or 'false'
     
    */
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()   //Hide the keyboard
        return true    //Should the system process the Return key or not?
        
    }
    
    /*
     
     Function to read the value entered by the user in the text field and instruct what to be done with it.
     This function is called after textFieldShouldReturn and accepts a textField parameter.
     
    */
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text                           
        
    }
    
    //Function that gets called when an editing session begins
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //Disable save button while editing.
        saveButton.isEnabled = false
    }
    
    //MARK: UIImagePickerControllerDelegate
    
    /*
     
     Function to cancel the selection of an image from the photo gallery when the user selects 'Cancel' Button.
     Accepts UIImagePickerController
 
    */
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)  //Dismiss the picker, if the user cancelled.
        
    }
    
    /*
     
     Function to cancel the selection of an image from the photo gallery when the user selects 'Cancel' Button.
     Accepts UIImagePickerController
     
     */
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        // Local variable inserted by Swift 4.2 migrator.

        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)  //info dictionary uses the original image that the user picked

        //the info dictionary may contain multiple representation of the image, so we're justmaking sure we have the original.
        guard let selectedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage
            else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        //setting the photoImageView to display the selected image
        photoImageView.image = selectedImage
        
        //dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Navigation
    
    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        //Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
        dismiss(animated: true, completion: nil)
    }
        
        else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        }
        else{
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    
    //Function to configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        //creating constants
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        //Setting the name of the meal to be passed to MealtableViewController after the unwind segue.
        meal = Meal(name: name, photo: photo, rating: rating)
        
    }
    
    //MARK: Actions
    
    /*
 
     Function to allow the user to add images to the app from their photo gallery.
     Accepts a UITapGestureRecognizer as a parameter.
     
    */
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        //hide the keyboard
        //To ensure that keyboard is dismissed (properly) when user taps the image
        
        nameTextField.resignFirstResponder()
        
        //UIImagePicker - lets a user pick media from their photo library
        let imagePickerController = UIImagePickerController()
        
        //Only allows photos to be picked
        imagePickerController.sourceType = .photoLibrary
        
        //Notify when user picks an image
        imagePickerController.delegate = self
        
        //Asking the view controller to present the image
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: Private Methods
    
    private func updateSaveButtonState() {
        //Disable the Save button if text fiel is empty.
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
