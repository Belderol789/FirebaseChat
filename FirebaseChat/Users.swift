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
    
    init() {
        name = ""
        email = ""
    }
    
    init(userName :String, userEmail: String) {
        self.name = userName
        self.email = userEmail
    }

}
