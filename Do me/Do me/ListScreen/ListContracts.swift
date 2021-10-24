//
//  ListContracts.swift
//  Do me
//
//  Created by Yavuz Selim Bitmez on 10.10.2021.
//

import Foundation

//MARK: View
protocol ListViewProtocol:NSObject{
    func handleOutput(_ output: ListPresenterOutput)
}

//MARK: Interactor

enum ListInteractorOutput {
    case showDetail(TaskModel)
    case showList([TaskModel])
}

protocol ListInteractorDelegate:NSObject {
    func handleOutput(_ output: ListInteractorOutput)
}
protocol ListInteractorProtocol:NSObject {
    var delegate:ListInteractorDelegate? {get set}
    func viewDidLoad()
    func didSelectRow(at indexpath:IndexPath)
    func updateSearchList(data:[ListPresentation])
}

//MARK: Presenter

enum ListPresenterOutput {
    case showList([ListPresentation])
}
protocol ListPresenterProtocol:NSObject {
    func viewDidLoad()
    func didSelectRow(at indexPath:IndexPath)
    func routeAdd()
    func updateSearchList(data:[ListPresentation])
}

//MARK: Router

enum ListRoute{
    case showDetail(TaskModel)
    case showAdd
}
protocol ListRouterProtocol:NSObject {
    func navigate(to route:ListRoute)
}
