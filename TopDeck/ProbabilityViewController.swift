//
//  ProbabilityViewController.swift
//  TopDeck
//
//  Created by Stephen Cheng on 2017-10-13.
//  Copyright © 2017 Stephen Cheng. All rights reserved.
//

import UIKit

class ProbabilityViewController: UIViewController {

    var probabilityTableViewController: ProbabilityTableViewController? = nil
    var detailItem: Deck? {
        didSet {
            // Update the view.
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ProbabililtyTableSegue" {
            if let childVC = segue.destination as? ProbabilityTableViewController {
                probabilityTableViewController = childVC
                probabilityTableViewController?.detailItem = detailItem
            }
        }
    }
    

}
