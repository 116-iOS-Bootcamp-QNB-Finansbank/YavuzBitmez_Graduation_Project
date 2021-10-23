//
//  DetailContracts.swift
//  Do me
//
//  Created by Yavuz Selim Bitmez on 18.10.2021.
//

import Foundation

protocol DetailViewModelDelegate:NSObject {
    func showTaskDetail(_ task: DetailPresentation)
}
protocol DetailViewModelProtocol {
    var delegate:DetailViewModelDelegate? { get set }
    func viewDidLoad()
    func saveTask(task:TaskModel)
    func removeTask(task:DetailPresentation)
    func updateTask(task:TaskModel)
}
