//
//  Item.swift
//  ToDoey
//
//  Created by Paul Raymond on 11/3/18.
//  Copyright © 2018 Paul Raymond. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    //inverse relationship
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
