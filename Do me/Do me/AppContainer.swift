//
//  AppContainer.swift
//  Do me
//
//  Created by Yavuz Selim Bitmez on 8.10.2021.
//

import UIKit

let appContainer = AppContainer()
class AppContainer {
    let databaseService = DatabaseService()
    let router = AppRouter()
    let notificationService = NotificationService()
}
