//
//  Users.swift
//  FirebaseChat
//
//  Created by Kemuel Clyde Belderol on 11/04/2017.
//  Copyright © 2017 Burst. All rights reserved.
//

import UIKit


class Users {
    var name: String?
    var email: String?
    var profilePicture: String?
    var messages: Array<Messages>?
    var id: String
  
    
    init() {
        name = ""
        email = ""
        profilePicture = ""
        messages = []
        id = ""
  
    }
    
    init(userName :String, userEmail: String, userPicture: String, uid: String) {
        self.name = userName
        self.email = userEmail
        self.profilePicture = userPicture
        self.id = uid
        //self.messages = messages
    }

}
