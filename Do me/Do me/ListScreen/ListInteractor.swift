//
//  ListInteractor.swift
//  Do me
//
//  Created by Yavuz Selim Bitmez on 10.10.2021.
//

import Foundation

class ListInteractor:NSObject,ListInteractorProtocol{
    weak var delegate: ListInteractorDelegate?
//    private var service: DatabaseServiceProtocol
    public var toDoList:[ListPresentation] = []
    private var finishedLists:[ListPresentation] = []

//    init(service:DatabaseServiceProtocol) {
//        self.service = service
//    }
    override init(){
        
    }
    func viewDidLoad() {
        getTodoList()
    }
    func getTodoList(){
        let date = Date()
        self.toDoList.append(ListPresentation(id: 1, header: "Yap", date: date, context: "Bunlarrrrrrrrrrrrrrrr"))
        self.toDoList.append(ListPresentation(id: 1, header: "Yap", date: date, context: "Bunlarrrrrrrrrrrrrrrr"))
        self.toDoList.append(ListPresentation(id: 1, header: "Yap", date: date, context: "Bunlarrrrrrrrrrrrrrrr"))
        self.toDoList.append(ListPresentation(id: 1, header: "Yap", date: date, context: "Bunlarrrrrrrrrrrrrrrr"))
        self.toDoList.append(ListPresentation(id: 1, header: "Yap", date: date, context: "Bunlarrrrrrrrrrrrrrrr"))
        self.toDoList.append(ListPresentation(id: 1, header: "Yap", date: date, context: "Bunlarrrrrrrrrrrrrrrr"))
        self.finishedLists.append(ListPresentation(id: 1, header: "Bittiiiii", date: date, context: "Bunlarrrrrrrrrrrrrrrr"))
        self.finishedLists.append(ListPresentation(id: 1, header: "Bittiiiii", date: date, context: "Bunlarrrrrrrrrrrrrrrr"))
        self.finishedLists.append(ListPresentation(id: 1, header: "Bittiiiii", date: date, context: "Bunlarrrrrrrrrrrrrrrr"))
//        service.movies { [weak self] response, error in
//            guard let self = self else { return }
//            guard let results = response?.feed.results else { return }
//            self.movies = results
//            self.delegate?.handleOutput(.showMovieList(results))
        self.delegate?.handleOutput(.showList(self.toDoList))
    }
    
    func didSelectRow(at indexpath: IndexPath) {
        let todo = toDoList[indexpath.row]
        self.delegate?.handleOutput(.showDetail(todo))
    }
    
    
}
