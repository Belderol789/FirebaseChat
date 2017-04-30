//
//  RegisterViewController.swift
//  FirebaseChat
//
//  Created by Kemuel Clyde Belderol on 10/04/2017.
//  Copyright © 2017 Burst. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController
{
    @IBOutlet weak var buttonSignup: UIButton!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldConfirmPass: UITextField!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var imageView: UIImageView!

    @IBAction func buttonBackTapped(_ sender: Any)
    {
        
        self.dismiss(animated: true, completion: nil)
        
    }
   
    @IBAction func buttonSignupTapped(_ sender: Any)
    {
        guard let email = textFieldEmail.text, let password = textFieldPassword.text, let confirmPassword = textFieldConfirmPass.text,
            let name = textFieldName.text else {return}
        
        if email == "" || password == "" || name == ""
        {
            print("Email or password is empty")
            return
        }
        
        if password != confirmPassword {
            print("Password not match")
            return
        }
        
        
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
            
            if error != nil {
                print("Error in signin: \(error)")
                return
            }
            
            
            guard let uid = user?.uid else {return}
            //save the user
            let imageName = NSUUID().uuidString
            let storageRef = FIRStorage.storage().reference().child("\(imageName).jpeg")
            let image = self.imageView.image
            guard let imageData = UIImageJPEGRepresentation(image!, 0.5) else { return }
            
            
            let metaData = FIRStorageMetadata()
            metaData.contentType = "image/jpeg"
             storageRef.put(imageData, metadata: metaData, completion: { (metadata, error) in
              
                if error != nil {
                    print("Image error: \(error)")
                    return
                }
                
                if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                    let userName = user?.email
                    let values = ["email": userName, "name": name, "profileImageUrl": profileImageUrl]
                    self.registerUserIntoDataBase(uid, values: values)
                }

             })
        })
        

    }
    
    private func registerUserIntoDataBase(_ uid: String, values: [String: Any]) {
        let ref = FIRDatabase.database().reference(fromURL: "https://fir-chat-49a54.firebaseio.com/")
        let usersReference = ref.child("users").child(uid)
        
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if err != nil {
                print("Error saving user: \(err)")
                return
            }
            
            
            self.dismiss(animated: true, completion: nil)
            
            
            
        })
        

    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()

        
    }
    
    func setupUI()
    {
        buttonBack.layer.cornerRadius = 8.0
        buttonSignup.layer.cornerRadius = 8.0
        stackView.layer.cornerRadius = 8.0
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseProfile(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
      
        
        
    }
    
    func chooseProfile(tapGestureRecognizer: UITapGestureRecognizer)
    {
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
       let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
        
    }
    
    
    



}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        print("User canceled out of picker")
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        var selectedImageFromPicker: UIImage?
       if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage
       {
        selectedImageFromPicker = editedImage
        
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage
        {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker
        {
            imageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}

