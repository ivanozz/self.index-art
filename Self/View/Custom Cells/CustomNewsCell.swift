//
//  CustomNewsCell.swift
//  Self
//
//  Created by admin on 22.05.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class CustomNewsCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var announce: UILabel!
    @IBOutlet var author: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }

}
