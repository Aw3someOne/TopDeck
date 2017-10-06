//
//  Deck.swift
//  TopDeck
//
//  Created by Stephen Cheng on 2017-10-06.
//  Copyright © 2017 Stephen Cheng. All rights reserved.
//

import UIKit

class Deck {
    var name: String
    var categories: [Category]
    init(name: String) {
        self.name = name
        self.categories = [Category]()
    }
}
