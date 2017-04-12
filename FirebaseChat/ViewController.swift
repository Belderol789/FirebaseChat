//
//  ViewController.swift
//  FirebaseChat
//
//  Created by Kemuel Clyde Belderol on 10/04/2017.
//  Copyright © 2017 Burst. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController
{
    

    override func viewDidLoad()
    {
      
        super.viewDidLoad()
  
    checkIfUserIsLoggedIn()
        
    }

    func checkIfUserIsLoggedIn()
    {
        if FIRAuth.auth()?.currentUser?.uid == nil
        {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
            
        } else
        {
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                
                if let dictionary = snapshot.value as? [String: Any]
                {
                    self.navigationItem.title = dictionary["name"] as? String
                }
               
            })
        }

    }
    
    @IBAction func buttonLogoutTapped(_ sender: Any)
    {
        handleLogout()

    }
    
    @IBAction func buttonComposeTapped(_ sender: Any)
    {
        if let contactsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContactsViewController") {
            
            present(contactsViewController, animated: true, completion: nil)
        }
    

      
    }
    
    
    func handleLogout()
    {
        do
        {
            try FIRAuth.auth()?.signOut()
        }
        catch let logoutError
        {
            print("Logout error: \(logoutError)")
        }
        let loginViewController = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
        present(loginViewController!, animated: true, completion: nil)
        

    }
    
   
    
}

