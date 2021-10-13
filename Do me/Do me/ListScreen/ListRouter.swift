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
            print("Go detail")
            // route detail page
        }
    }
    
    
}
