//
//  ContactTableViewCell.swift
//  
//
//  Created by Kemuel Clyde Belderol on 12/04/2017.
//
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "ContactTableViewCell"
    static let cellNib = UINib(nibName: ContactTableViewCell.cellIdentifier, bundle: Bundle.main)
    
    
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
