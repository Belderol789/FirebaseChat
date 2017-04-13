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
            
            FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
                self.user?.id = snapshot.key
            })
            
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
        let ref = FIRDatabase.database().reference().child("messages")
        let childRef = ref.childByAutoId()
        let toId = user?.id
        let fromID = FIRAuth.auth()?.currentUser?.uid
        let values = ["text": textFieldChat.text!, "uid": toId!, "fromID": fromID!, "time": dateFormatter.string(from: Date())] as [String : Any]
        childRef.updateChildValues(values)
        
        self.addToArray(text: textFieldChat.text!, toUser: toId!, fromUser: fromID!, date: dateFormatter.string(from: Date()))
        
        textFieldChat.text = ""
        
        
        
    }
    
    
    func addToArray(text: String, toUser: String, fromUser: String, date: String) {
        let text = text
        let toUser = toUser
        let fromUser = fromUser
        let date = date
        
        let newMessage = Messages(text: text, toUser: toUser, fromUser: fromUser, date: date)
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as? ChatTableViewCell
        
     
//        cell?.labelBody.text = user?.name
//        cell?.labelDate.text = "today"
//        cell?.labelFrom.text = "hello"
//        cell?.labelTo.text = "yeah"
        
        
        return cell!
    }
}
