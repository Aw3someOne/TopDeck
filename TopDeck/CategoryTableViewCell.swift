//
//  CategoryTableViewCell.swift
//  TopDeck
//
//  Created by Stephen Cheng on 2017-10-13.
//  Copyright © 2017 Stephen Cheng. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
