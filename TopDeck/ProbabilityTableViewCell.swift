//
//  ProbabilityTableViewCell.swift
//  TopDeck
//
//  Created by Stephen Cheng on 2017-10-13.
//  Copyright © 2017 Stephen Cheng. All rights reserved.
//

import UIKit

class ProbabilityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryDesired: UILabel!
    @IBOutlet weak var categoryDesiredStepper: UIStepper!
    var category: Category? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func categoryDesiredStepperChanged(_ sender: UIStepper) {
        category?.desired = Int(sender.value)
        categoryDesired.text = "\(category?.desired.description ?? "0") of \(category?.count.description ?? "3")"
    }
    
}
