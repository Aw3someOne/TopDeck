//
//  CategoryTableViewCell.swift
//  TopDeck
//
//  Created by Stephen Cheng on 2017-10-13.
//  Copyright © 2017 Stephen Cheng. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var categoryCountLabel: UILabel!
    @IBOutlet weak var categoryCountStepper: UIStepper!
    var detailViewController: DetailViewController?
    
    var category: Category? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        categoryCountStepper.maximumValue = 60
        categoryCountStepper.minimumValue = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        // super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func categoryEdited(_ sender: UITextField) {
        category?.name = sender.text!
    }
    
    @IBAction func categoryCountStepperChanged(_ sender: UIStepper) {
        category?.count = Int(sender.value)
        category?.desired = min((category?.count)!, (category?.desired)!)
        categoryCountLabel.text = category?.count.description
        categoryCountLabel.sizeToFit()
        detailViewController?.updateCardCount()
    }
    
}
