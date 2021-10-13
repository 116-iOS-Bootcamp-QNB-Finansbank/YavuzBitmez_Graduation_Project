//
//  ToDoListBuilder.swift
//  Do me
//
//  Created by Yavuz Selim Bitmez on 8.10.2021.
//

import UIKit

class ListBuilder {
    static func build() -> ListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(identifier: "ListViewController") as! ListViewController
        let interactor = ListInteractor()
        let router = ListRouter(view: view)
        let presenter = ListPresenter(interactor: interactor, view: view, router: router)
        interactor.delegate = presenter
        view.presenter = presenter
        return view
    }
}
