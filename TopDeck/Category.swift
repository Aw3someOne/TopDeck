//
//  Category.swift
//  TopDeck
//
//  Created by Stephen Cheng on 2017-10-06.
//  Copyright © 2017 Stephen Cheng. All rights reserved.
//

import UIKit

class Category {
    var name: String
    var count: Int
    var desired: Int
    init?(name: String, count: Int) {
        if name.isEmpty {
            return nil
        }
        self.name = name
        self.count = count
        self.desired = 0
    }
}
