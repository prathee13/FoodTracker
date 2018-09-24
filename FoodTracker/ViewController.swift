//
//  ViewController.swift
//  FoodTracker
//
//  Created by Pratheeksha Ravindra Naik on 2018-09-22.
//  Copyright © 2018 com/uregina. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {   //Acts as valid text deligate and to adopt picker and controller delegates
    
    //MARK: Properties

    @IBOutlet weak var nameTextField: UITextField!   //Linking text-field to code
    
    @IBOutlet weak var mealNameLabel: UILabel!  //Connecting Label to code
    
    @IBOutlet weak var photoImageView: UIImageView!  //Connecting Image to the code
    
    
    @IBOutlet weak var ratingControl: RatingControl!
    
    
    
    override func viewDidLoad() {     //called when view controller's view is loaded from the storyboard
        super.viewDidLoad()
        //Handle the text field's user input through delegate callbacks.
        
        nameTextField.delegate = self  //Refers to ViewControllerClass
    }

    //MARK: UITxtFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the keyboard
        textField.resignFirstResponder()
        return true    //Should the system process the Return key or not?
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Function to resign the first-responder status
        
        mealNameLabel.text = textField.text
        
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
    
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
