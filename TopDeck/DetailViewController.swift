//
//  DetailViewController.swift
//  TopDeck
//
//  Created by Stephen Cheng on 2017-10-06.
//  Copyright © 2017 Stephen Cheng. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var deckTextField: UITextField!

    func configureView() {
        // Update the user interface for the detail item.
        if let deck = detailItem {
            if let textField = deckTextField {
                textField.text = deck.name
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: Deck? {
        didSet {
            // Update the view.
            configureView()
        }
    }

    @IBAction func deckTextFieldEdited(_ sender: UITextField) {
        detailItem?.name = deckTextField.text!
    }
    
}

