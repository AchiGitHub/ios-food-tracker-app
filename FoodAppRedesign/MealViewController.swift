//
//  ViewController.swift
//  FoodAppRedesign
//
//  Created by Achintha Ikiriwatte on 11/19/20.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var mealTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mealTextField.delegate = self
        
        updateSaveButtonState()
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("Save button was not pressed, Cancelling", log:OSLog.default, type: .debug)
            return
        }
        let name = mealTextField.text ?? ""
        let photo = photoImageView.image
        
        meal = Meal(name: name, photo: photo)
    }
    
    // MARK: Actions
    @IBAction func changeLabelName(_ sender: UIButton) {
//        mealLabel.text = "Default Text"
    }
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated:true, completion: nil)
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    
    
    @IBAction func selectImageFromLibrary(_ sender: Any) {
        mealTextField.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: false, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as?
                UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        photoImageView.image = selectedImage
        
        dismiss(animated: false, completion: nil)
    }
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = mealTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
}

