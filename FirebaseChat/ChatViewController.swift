//
//  ChatViewController.swift
//  FirebaseChat
//
//  Created by Kemuel Clyde Belderol on 12/04/2017.
//  Copyright © 2017 Burst. All rights reserved.
//

import UIKit
import Firebase



class ChatViewController: UIViewController

{
    @IBOutlet weak var textFieldChat: UITextField!
    @IBOutlet weak var buttonSend: UIButton!
    @IBOutlet weak var navigationBar: UINavigationBar!
    var ref: FIRDatabaseReference!
    var messages : [Messages] = []
    var message : Messages?
    var user: Users?
        {
        didSet
        {
            navigationItem.title = user?.name
            print("Title: \(navigationItem.title)")
        }
    }

    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            
            tableView.register(ChatTableViewCell.cellNib, forCellReuseIdentifier: ChatTableViewCell.cellIdentifier)
            
            tableView.register(ChatTableViewCell.cellNib, forCellReuseIdentifier: ChatTableViewCell.cellIdentifier)
            
        }
    }
    
    let dateFormatter : DateFormatter = {
        let _dateFormatter  = DateFormatter()
        let locale = Locale(identifier: "en_US_POSIX")
        _dateFormatter.locale = locale
        _dateFormatter.dateFormat = "T'HH':'mm':'ss'Z'"
        return _dateFormatter
    }()


 
    
    @IBAction func buttonSend(_ sender: Any)
    {
        handleSend()

        
    }
    
    func handleSend() {
        let ref = FIRDatabase.database().reference().child("messages")
        let childRef = ref.childByAutoId()
        let toId = user?.id
        let fromID = FIRAuth.auth()?.currentUser?.uid
        let name = user?.name
        let values = ["text": textFieldChat.text!, "uid": toId!, "fromID": fromID!, "name": name!,"time": dateFormatter.string(from: Date())] as [String : Any]
        childRef.updateChildValues(values)
        textFieldChat.text = ""
        
        tableView.reloadData()

    }
    

    
    func addToArray(text: String, toUser: String, fromUser: String, date: String) {
        let text = text
        let toUser = toUser
        let fromUser = fromUser
        let date = date
      
        
        let newMessage = Messages(text: text, toUser: toUser, fromUser: fromUser, date: date, name: "")
        self.messages.append(newMessage)

    }

    
    
  
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()

       
    }
    
    
    func setupUI()
    {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        buttonSend.layer.borderWidth = 1
        buttonSend.layer.borderColor = UIColor.black.cgColor
        textFieldChat.layer.borderWidth = 1
        textFieldChat.layer.borderColor = UIColor.black.cgColor
    }
    
   

}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as? ChatTableViewCell
        
        let currentMessage = messages[indexPath.row]
        
     
        cell?.labelBody.text = currentMessage.text
        cell?.labelDate.text = currentMessage.date
        cell?.labelFrom.text = currentMessage.fromUser
        cell?.labelTo.text = user?.name
        
        
        return cell!
    }
}
