//
//  NewsCell.swift
//  Self
//
//  Created by admin on 21.05.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet var shortText: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var author: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
