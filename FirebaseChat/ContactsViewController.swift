//
//  ContactsViewController.swift
//  
//
//  Created by Kemuel Clyde Belderol on 11/04/2017.
//
//

import UIKit
import Firebase

class ContactsViewController: UIViewController
{
    let ref = FIRDatabase.database().reference()
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            
            tableView.register(ContactTableViewCell.cellNib, forCellReuseIdentifier: ContactTableViewCell.cellIdentifier)
            
            tableView.register(ContactTableViewCell.cellNib, forCellReuseIdentifier: ContactTableViewCell.cellIdentifier)
            
            
        }
    }

        
    
    var users : [Users] = []


    @IBAction func buttonCancelTapped(_ sender: Any)
        
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()
        fetchUser()

       
    }
    
    func setupUI()
    {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    func fetchUser()
    {
        ref.child("users").observe(.childAdded, with: { (snapshot) in
            print("Added:", snapshot)
            guard let info = snapshot.value as? NSDictionary else { return }
            let user = Users()
            let userName = info["name"] as? String
            let userEmail = info["email"] as? String
            let userPictures = info["profileImageUrl"] as? String
            user.id = snapshot.key
            
            
            self.addToArray(name: userName!, email: userEmail!, profilePicture: userPictures!, uid: user.id)
 
            self.tableView.reloadData()
            
                    }, withCancel: nil)
    }
    
    func addToArray(name: String, email: String, profilePicture: String, uid: String) {
        let name = name
        let email = email
        let picture = profilePicture
        let uid = uid
        
        let newUser = Users(userName :name, userEmail: email, userPicture: picture, uid: uid)
        self.users.append(newUser)

    }

}

extension ContactsViewController: UITableViewDataSource, UITableViewDelegate

    
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as? ContactTableViewCell
        
        let currentUser = users[indexPath.row]
        
        cell?.nameLabel.text = currentUser.name
        cell?.emailLabel.text = currentUser.email
        cell?.profileImageView.layer.cornerRadius = 30
        cell?.profileImageView.layer.borderWidth = 1
        cell?.profileImageView.layer.borderColor = UIColor.black.cgColor
        cell?.profileImageView.layer.masksToBounds = true
        cell?.profileImageView.downloadedFrom(link: currentUser.profilePicture!)
        
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
            
            let user = self.users[indexPath.row]
            self.showChatFor(user: user)
        
    }
    
    func showChatFor(user: Users)
    {
        let chatViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        chatViewController.user = user
        self.present(chatViewController, animated: true, completion: nil)
        
    }
    
    
    

    
       
    
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit)
    {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
                }
            }.resume()
        }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}


