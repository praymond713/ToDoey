//
//  Category.swift
//  ToDoey
//
//  Created by Paul Raymond on 11/3/18.
//  Copyright © 2018 Paul Raymond. All rights reserved.
//

import Foundation
import RealmSwift


class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
