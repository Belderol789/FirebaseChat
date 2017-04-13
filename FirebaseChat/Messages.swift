//
//  Messages.swift
//  FirebaseChat
//
//  Created by Kemuel Clyde Belderol on 12/04/2017.
//  Copyright © 2017 Burst. All rights reserved.
//

import Foundation
import UIKit

class Messages
{
    var text : String
    var toUser : String
    var fromUser : String
    var date : String
    
    init() {
        text = ""
        toUser = ""
        fromUser = ""
        date = ""
        
    }
    
    init(text :String, toUser: String, fromUser: String, date: String) {
        self.text = text
        self.toUser = toUser
        self.fromUser = fromUser
        self.date = date
       
    }



    
}
