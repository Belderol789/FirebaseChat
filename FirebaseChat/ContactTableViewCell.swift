//
//  ContactTableViewCell.swift
//  FirebaseChat
//
//  Created by Kemuel Clyde Belderol on 11/04/2017.
//  Copyright © 2017 Burst. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
   // @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
