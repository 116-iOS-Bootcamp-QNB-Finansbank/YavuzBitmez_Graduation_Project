//
//  DetailBuilder.swift
//  Do me
//
//  Created by Yavuz Selim Bitmez on 13.10.2021.
//

import Foundation

class DetailBuilder {
    static func build() -> DetailViewController {
        let viewController = DetailViewController()
        let viewModel = DetailViewModel()
        viewModel.dbService = appContainer.databaseService
        viewModel.nfService = appContainer.notificationService
        viewController.viewModel = viewModel
        return viewController
    }
    static func build(with data: TaskModel) -> DetailViewController {
        let viewController = DetailViewController()
        let viewModel = DetailViewModel()
        viewModel.dbService = appContainer.databaseService
        viewModel.nfService = appContainer.notificationService
        viewModel.task = data
        viewController.viewModel = viewModel
        viewController.editable = true
        return viewController
    }
}
