//
//  ViewController.swift
//  PracticeFoodTracker
//
//  Created by Lezardvaleth on 2019/2/8.
//  Copyright © 2019 Lezardvaleth. All rights reserved.
//

import UIKit
import os.log

class BoobViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    //MARK:Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var boobPic: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddBoobMode = presentingViewController is UINavigationController
        if isPresentingInAddBoobMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationControl = navigationController {
            owningNavigationControl.popViewController(animated: true)
        }
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    
    
    /*
     This value is either passed by `BoobTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new boob.
     */
    var boob: Boob?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        
        // Set up views if editing an existing Meal.
        if let boob = boob {
            navigationItem.title = boob.name
            nameTextField.text = boob.name
            boobPic.image = boob.photo
            ratingControl.rating = boob.rating
        }
        
        // Enable the Save button only if the text field has a valid Boob name.
        updateSaveButtonStates()
    }
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the save button while editing
        saveButton.isEnabled = false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonStates()
        navigationItem.title = textField.text
    }
    //MARK:UIImageControlDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        // Set photoImageView to display the selected image.
        boobPic.image = selectedImage
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    //MARK: Navigation
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let name = nameTextField.text ?? ""
        let photo = boobPic.image
        let rating = ratingControl.rating
        //set the boob to be passed to BoobTableViewController after the unwind segue
        boob = Boob(name: name, photo: photo, rating: rating)
    }
    
    
    
    
    //MARK:Action
//    @IBAction func setDefaultLabelText(_ sender: UIButton) {
//        boobNameLabel.text = "Default Text"
//    }
//    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
//        nameTextField.resignFirstResponder()
//        let imagePickController = UIImagePickerController()
//        imagePickController.sourceType = .photoLibrary
//        imagePickController.delegate = self
//        present(imagePickController,animated: true,completion: nil)
//    }
    
//    @IBAction func testNameChanged(_ sender: UITapGestureRecognizer) {
//    }
    //Mistake : Don't change the function name once it set by IB
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        let imagePickController = UIImagePickerController()
        imagePickController.sourceType = .photoLibrary
        imagePickController.delegate = self
        present(imagePickController,animated: true,completion: nil)

    }
    
    
    //MARK: Private methods
    private func updateSaveButtonStates() {
        //Disable the save button if the text field is empty
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
}

