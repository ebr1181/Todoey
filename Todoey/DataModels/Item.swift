//
//  Item.swift
//  Todoey
//
//  Created by Ernesto Ruiz on 9/14/19.
//  Copyright © 2019 Ernesto Ruiz. All rights reserved.
//

import Foundation

class Item : Codable {
    
    var title:String = ""
    var done:Bool = false
    
    init() {
        
    }
    
    convenience init(itemTitle:String, Iscompleted:Bool?) {
        self.init()
        
        self.title = itemTitle
        self.done = Iscompleted  == nil ? false : Iscompleted!
        
    }
    
    static func getInititalData(numberOfRows:Int) -> [Item] {
        let minCount = 3
        var loopFor = minCount
        var itemCollection:[Item] = []
        
        if(numberOfRows > minCount){
            loopFor = numberOfRows
        }
        
        for i in 0...loopFor {
            let listItem = Item(itemTitle: "Item: \(i)", Iscompleted: false)
            itemCollection.append(listItem)
        }
        
        return itemCollection
    }
}
