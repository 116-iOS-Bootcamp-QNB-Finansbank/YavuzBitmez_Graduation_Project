//
//  Task.swift
//  Do me
//
//  Created by Yavuz Selim Bitmez on 30.09.2021.
//

import Foundation

class TaskModel {
    var id:Int
    var header:String
    var date:Date
    var context:String
    
    init(id:Int,header:String,date:Date,context:String) {
        self.id = id
        self.header = header
        self.date = date
        self.context = context
    }
}
