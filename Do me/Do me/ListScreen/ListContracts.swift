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
    case showDetail(ListPresentation)
    case showList([ListPresentation])
}

protocol ListInteractorDelegate:NSObject {
    func handleOutput(_ output: ListInteractorOutput)
}
protocol ListInteractorProtocol:NSObject {
    var delegate:ListInteractorDelegate? {get set}
    func viewDidLoad()
    func didSelectRow(at indexpath:IndexPath)
}

//MARK: Presenter

enum ListPresenterOutput {
    case showList([ListPresentation])
}
protocol ListPresenterProtocol:NSObject {
    func viewDidLoad()
    func didSelectRow(at indexPath:IndexPath)
}

//MARK: Router

enum ListRoute{
    case showDetail(ListPresentation)
}
protocol ListRouterProtocol:NSObject {
    func navigate(to route:ListRoute)
}
