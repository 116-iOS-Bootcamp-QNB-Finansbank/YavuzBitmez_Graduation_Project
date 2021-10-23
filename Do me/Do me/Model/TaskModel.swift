//
//  Task.swift
//  Do me
//
//  Created by Yavuz Selim Bitmez on 30.09.2021.
//

import Foundation

class TaskModel {
    var id :String
    var header:String
    var date:Date
    var content:String
    var repeats:Bool
    
    init(header:String,date:Date,content:String,id:String,repeats:Bool) {
        self.id = id
        self.header = header
        self.date = date
        self.content = content
        self.repeats = repeats
    }
}
