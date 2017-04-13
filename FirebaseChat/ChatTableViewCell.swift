//
//  ChatTableViewCell.swift
//  
//
//  Created by Kemuel Clyde Belderol on 12/04/2017.
//
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "ChatTableViewCell"
    static let cellNib = UINib(nibName: ChatTableViewCell.cellIdentifier, bundle: Bundle.main)
    
    
    @IBOutlet var labelBody: UILabel!
    @IBOutlet var labelTo: UILabel!
    @IBOutlet var labelFrom: UILabel!
    @IBOutlet var labelDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
