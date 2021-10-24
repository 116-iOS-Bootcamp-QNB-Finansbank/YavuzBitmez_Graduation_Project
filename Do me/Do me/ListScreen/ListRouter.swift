//
//  ListRouter.swift
//  Do me
//
//  Created by Yavuz Selim Bitmez on 10.10.2021.
//

import UIKit

class ListRouter: NSObject,ListRouterProtocol {
    private unowned let view: UIViewController
    
    init(view:UIViewController) {
        self.view = view
    }
    func navigate(to route: ListRoute) {
        switch route {
        case .showDetail(let task):
            let viewController = DetailBuilder.build(with: task)
            self.view.navigationController?.pushViewController(viewController, animated: true)
            // route detail page
        case .showAdd:
            let viewController = DetailBuilder.build()
            self.view.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    
}
