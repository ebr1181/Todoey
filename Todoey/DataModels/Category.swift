//
//  Category.swift
//  Todoey
//
//  Created by Ernesto Ruiz on 9/21/19.
//  Copyright © 2019 Ernesto Ruiz. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
    @objc dynamic var dateCreated : Date = Date()
}
