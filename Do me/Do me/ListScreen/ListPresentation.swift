//
//  ListPresentation.swift
//  Do me
//
//  Created by Yavuz Selim Bitmez on 10.10.2021.
//

import Foundation

struct ListPresentation {
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

