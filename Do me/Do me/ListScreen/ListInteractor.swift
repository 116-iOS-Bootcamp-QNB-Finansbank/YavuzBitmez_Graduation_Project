//
//  ListInteractor.swift
//  Do me
//
//  Created by Yavuz Selim Bitmez on 10.10.2021.
//

import Foundation

class ListInteractor:NSObject,ListInteractorProtocol{
    
    weak var delegate: ListInteractorDelegate?
    private var service: DatabaseServiceProtocol
    public var toDoList:[TaskModel] = []

    init(service:DatabaseServiceProtocol) {
        self.service = service
    }

    func viewDidLoad() {
        getTodoList()
    }
    func getTodoList(){
        service.todoList { [weak self] response, error in
            guard let self = self else { return }
            guard let results = response else { return }
            self.toDoList = results
            self.delegate?.handleOutput(.showList(results))
        }
    }
    func updateSearchList(data:[ListPresentation]) {
        self.toDoList.removeAll()
        for i in data {
            toDoList.append(TaskModel(header: i.header, date: i.date, content: i.content, id: i.id, repeats: i.repeats))
        }
        NSLog("[ListViewController] Updated List")
    }
    
    func didSelectRow(at indexpath: IndexPath) {
        let todo = toDoList[indexpath.row]
        self.delegate?.handleOutput(.showDetail(todo))
    }
}
