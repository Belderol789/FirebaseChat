//
//  Message.swift
//  FirebaseChat
//
//  Created by Kemuel Clyde Belderol on 13/04/2017.
//  Copyright © 2017 Burst. All rights reserved.
//

import UIKit

class Message: NSObject {
    
    
    var text: String?
    var date: String?
    var toId: String?
    var fromPerson: String?
    
    
    override init() {
        text = ""
        date = ""
        toId = ""
        fromPerson = ""
    }
    

}
