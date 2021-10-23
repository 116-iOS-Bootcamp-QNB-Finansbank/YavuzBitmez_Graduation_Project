//
//  ListPresentation.swift
//  Do me
//
//  Created by Yavuz Selim Bitmez on 10.10.2021.
//

import Foundation

struct ListPresentation {
    var header:String
    var date:Date
    var content:String
    var id:String
    var repeats:Bool
    
    init(task:TaskModel) {
        self.header = task.header
        self.date = task.date
        self.content = task.content
        self.id = task.id
        self.repeats = task.repeats
    }
}
