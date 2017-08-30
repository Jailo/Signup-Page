//
//  FeedTableViewCell.swift
//  ParseStarterProject-Swift
//
//  Created by Jaiela London on 8/28/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    @IBOutlet var usernameLabel: UILabel!

    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var postedImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
