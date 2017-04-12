//
//  LoginViewController.swift
//  FirebaseChat
//
//  Created by Kemuel Clyde Belderol on 10/04/2017.
//  Copyright © 2017 Burst. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController
{
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var buttonRegister: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBAction func buttonRegisterTapped(_ sender: Any)
    {
        
        let registerViewController = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController")
        present(registerViewController!, animated: true, completion: nil)
    }
    
    @IBAction func buttonLoginTapped(_ sender: Any)
    {
        guard let email = textFieldEmail.text, let password = textFieldPassword.text else { return }
        
       FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
        
        if error != nil
        {
            print("error login: \(error)")
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
        buttonLogin.layer.cornerRadius = 8.0
        buttonRegister.layer.cornerRadius = 8.0
        stackView.layer.cornerRadius = 8.0
        imageView.image = #imageLiteral(resourceName: "Pokeball")
     
    }
    
   

}

