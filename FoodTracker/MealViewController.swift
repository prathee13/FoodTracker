//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Pratheeksha Ravindra Naik on 2018-09-22.
//  Copyright © 2018 com/uregina. All rights reserved.
//

import os.log //importa unified logging system
import UIKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {   //Acts as valid text deligate and to adopt picker and controller delegates
    
    //MARK: Properties

    @IBOutlet weak var nameTextField: UITextField!   //Linking text-field to code
    
    
    @IBOutlet weak var photoImageView: UIImageView!  //Connecting Image to the code
    
    
    @IBOutlet weak var ratingControl: RatingControl!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
/* This value is either passed by 'MealTableViewController' in 'prepare(for: sender:)'
 or constructed as part of adding a new meal */
    
    var meal: Meal?
    
    
    override func viewDidLoad() {     //called when view controller's view is loaded from the storyboard
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

    //MARK: UITxtFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the keyboard
        textField.resignFirstResponder()
        return true    //Should the system process the Return key or not?
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text                           
        
    }
    
    //gets called when an editing session begins
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //Disable save button while editing.
        saveButton.isEnabled = false
    }
    
    //MARK: UIImagePickerControllerDelegate
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //Dismiss the picker, if the user cancelled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        //the infor dictionary may contain multiple representation of the image, so we're justmaking sure we have the original.
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
    
    //This method lets us configure a view controller before it's presented.
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
