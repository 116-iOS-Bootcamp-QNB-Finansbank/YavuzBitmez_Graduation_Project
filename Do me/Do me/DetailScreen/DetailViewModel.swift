//
//  DetailViewModel.swift
//  Do me
//
//  Created by Yavuz Selim Bitmez on 18.10.2021.
//

import Foundation

class DetailViewModel: DetailViewModelProtocol {

    weak var delegate: DetailViewModelDelegate?
    var dbService: DatabaseServiceProtocol?
    var nfService: NotificationServiceProtocol?

    var task:TaskModel? = nil

    func viewDidLoad() {
        delegate?.showTaskDetail(DetailPresentation(task: task!))
    }
    func saveTask(task:TaskModel){
        nfService?.notificationSave(task: task)
        dbService?.todoSave(task: task)
        UserDefaults.standard.setValue(true, forKey: "Update")
    }
    func removeTask(task: DetailPresentation) {
        nfService?.notificationRemove(task: task)
        dbService?.todoRemove(task: task)
        UserDefaults.standard.setValue(true, forKey: "Update")
    }
    func updateTask(task: TaskModel) {
        nfService?.notificationSave(task: task)
        dbService?.todoUpdate(task: task)
        UserDefaults.standard.setValue(true, forKey: "Update")
    }
}
