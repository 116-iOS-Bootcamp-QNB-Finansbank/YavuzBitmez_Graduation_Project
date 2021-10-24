//
//  Router.swift
//  Do me
//
//  Created by Yavuz Selim Bitmez on 8.10.2021.
//

import UIKit

class AppRouter {
    func start(scene:UIWindowScene)->UIWindow{
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: ListBuilder.build())
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        window.windowScene = scene
        return window
    }
}
