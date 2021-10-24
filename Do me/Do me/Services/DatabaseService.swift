//
//  DatabaseManager.swift
//  Do me
//
//  Created by Yavuz Selim Bitmez on 18.10.2021.
//

import Foundation

protocol DatabaseServiceProtocol {
    func todoList(completion:@escaping ([TaskModel]?,Error?)->Void)
    func todoRemove(task:DetailPresentation)
    func todoUpdate(task:TaskModel)
    func todoSave(task:TaskModel)
}
class DatabaseService:DatabaseServiceProtocol{

    func todoList(completion: @escaping ([TaskModel]?, Error?) -> Void) {
        CoreDataManager.shared.fetchData(completion: completion)
    }
    func todoRemove(task:DetailPresentation) {
        CoreDataManager.shared.removeData(data: task)
    }
    
    func todoUpdate(task:TaskModel) {
        CoreDataManager.shared.updateData(data: task)
    }
    
    func todoSave(task:TaskModel) {
        CoreDataManager.shared.saveData(data: task)
    }
    
    deinit {
        NSLog("[DatabaseService] Deinit")
    }
}
