//
//  ListPresenter.swift
//  Do me
//
//  Created by Yavuz Selim Bitmez on 10.10.2021.
//

import Foundation

class ListPresenter: NSObject,ListPresenterProtocol{
    private unowned let view: ListViewProtocol
    private let router: ListRouterProtocol
    private var interactor: ListInteractorProtocol {
        didSet {
            self.interactor.delegate = self
        }
    }
    
    init(interactor: ListInteractorProtocol,
         view: ListViewProtocol,
         router: ListRouterProtocol) {
        self.interactor = interactor
        self.view = view
        self.router = router
    }
    func viewDidLoad() {
        interactor.viewDidLoad()
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        interactor.didSelectRow(at: indexPath)
    }
    
    
}

extension ListPresenter:ListInteractorDelegate{
    func handleOutput(_ output: ListInteractorOutput) {
        switch output {
        case .showList(let tasks):
            view.handleOutput(.showList(tasks))
        case .showDetail(let task):
            router.navigate(to: .showDetail(task))
        }
    }
    
    
}
