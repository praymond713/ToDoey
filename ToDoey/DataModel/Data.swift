//
//  Data.swift
//  ToDoey
//
//  Created by Paul Raymond on 11/2/18.
//  Copyright © 2018 Paul Raymond. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
    
}

