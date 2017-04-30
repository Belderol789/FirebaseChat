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
    
    @IBOutlet weak var tableView: UITableView!
    var users : [Messages] = []

    override func viewDidLoad()
    {
      
        super.viewDidLoad()
        
    checkIfUserIsLoggedIn()
    setupUI()
    fetchUser()
        
  
        
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
    
    func setupUI() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
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
    
    func fetchUser()
    {
        let ref = FIRDatabase.database().reference()
        ref.child("messages").observe(.childAdded, with: { (snapshot) in
            print("Added:", snapshot)
            guard let info = snapshot.value as? NSDictionary else { return }
            let text = info["text"] as? String
            let name = info["name"] as? String
        
            
            self.addToArray(text: text!, name: name!)
            
            self.tableView.reloadData()
            
        }, withCancel: nil)
    }
    
    func addToArray(text: String, name: String) {
 
        let text = text
        let name = name

        
        let newUser = Messages(text: text, toUser: "", fromUser: "", date: "", name: name)
        self.users.append(newUser)
        
    }
    
}

    
   
    


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentUser = users[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        
        cell.textLabel?.text = currentUser.text
        cell.detailTextLabel?.text = currentUser.name
       
        
    
        return cell
    }
    
    
}

