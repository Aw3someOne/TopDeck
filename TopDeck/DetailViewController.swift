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
    @IBOutlet weak var cardCount: UILabel!
    @IBOutlet weak var probablityButton: UIButton!
    
    var categoryTableViewController: CategoryTableViewController? = nil
    var probabilityViewController: ProbabilityViewController? = nil
    
    func configureView() {
        // Update the user interface for the detail item.
        if let deck = detailItem {
            if let textField = deckTextField {
                textField.text = deck.name
                updateCardCount()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if detailItem == nil {
            self.view.isUserInteractionEnabled = false
        }
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
        if !deckTextField.text!.isEmpty {
            detailItem?.name = deckTextField.text!
        }
    }
    
    @IBAction func editCategoryButton(_ sender: UIButton) {
        if let edit = categoryTableViewController?.tableView.isEditing {
            sender.setTitle(edit ? "Edit" : "Done", for: UIControlState.normal)
            categoryTableViewController?.tableView.setEditing(!edit, animated: true)
        }
    }
    
    @IBAction func addCategoryButton(_ sender: UIButton) {
        if let deck = detailItem {
            deck.categories.insert(Category(name: "New Category\((detailItem?.categories.count)! > 0 ? " \((detailItem?.categories.count)! + 1)" : "")", count: 0)!, at: 0)
        }
        let indexPath = IndexPath(row: 0, section: 0)
        categoryTableViewController?.tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CategoryTableSegue" {
            if let childVC = segue.destination as? CategoryTableViewController {
                categoryTableViewController = childVC
                categoryTableViewController?.detailItem = detailItem
                categoryTableViewController?.detailViewController = self
            }
        } else if segue.identifier == "ProbabilitySegue" {
            if let childVC = segue.destination as? ProbabilityViewController {
                probabilityViewController = childVC
                probabilityViewController?.detailItem = detailItem
            }
        }
    }
    
    func updateCardCount() {
        cardCount.text = "\((detailItem?.count)!) Cards"
        cardCount.sizeToFit()
        let count = (detailItem?.count)!
        let valid = (40 <= count) && (count <= 60)
        probablityButton.isEnabled = valid
        probablityButton.setTitle(valid ? "Probability Calculator" : "Illegal Deck Size", for: UIControlState.normal)
    }
    
}

