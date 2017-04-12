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
    @IBOutlet weak var tableView: UITableView!
    var users = [String]()
    var emails = [String]()
    var profilePics = [String]()

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
            let name = info["name"] as? String
            let email = info["email"] as? String
            let pictures = info["profileImageUrl"] as? String
         
           
            
            
           
            self.users.append(name!)
            self.emails.append(email!)
            self.profilePics.append(pictures!)
            
            print("urls:\(pictures)")
            
            
            self.tableView.reloadData()
            
                    }, withCancel: nil)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ContactTableViewCell
        
        cell?.nameLabel.text = users[indexPath.row]
        cell?.emailLabel.text = emails[indexPath.row]
        cell?.profileImageView.layer.cornerRadius = 30
        cell?.profileImageView.layer.masksToBounds = true
        cell?.profileImageView.downloadedFrom(link: profilePics[indexPath.row])
        
        
        
        return cell!
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


