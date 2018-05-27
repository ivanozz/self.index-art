//
//  CustomCommentCell.swift
//  Self
//
//  Created by admin on 25.05.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation

import UIKit

class CustomCommentCell: UITableViewCell {
    
    @IBOutlet var author: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var comment: UITextView!
    @IBOutlet var nest: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
