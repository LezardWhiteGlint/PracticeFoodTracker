//
//  ViewController.swift
//  PracticeFoodTracker
//
//  Created by Lezardvaleth on 2019/2/8.
//  Copyright © 2019 Lezardvaleth. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    //MARK:Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var boobNameLabel: UILabel!
    @IBOutlet weak var boobPic: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
    }
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        boobNameLabel.text = textField.text
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
    
}

