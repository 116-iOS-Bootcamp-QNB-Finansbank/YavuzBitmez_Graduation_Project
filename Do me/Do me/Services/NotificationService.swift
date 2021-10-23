//
//  NotificationService.swift
//  Do me
//
//  Created by Yavuz Selim Bitmez on 18.10.2021.
//

import Foundation

protocol NotificationServiceProtocol {
    func notificationRemove(task:DetailPresentation)
    func notificationSave(task:TaskModel)
}

class NotificationService:NotificationServiceProtocol{
  
    func notificationSave(task: TaskModel) {
        LocalNotificationManager.shared.addNotification(task: task)
    }
    
    func notificationRemove(task: DetailPresentation) {
        LocalNotificationManager.shared.removeNotification(task: task)
    }
    deinit {
        NSLog("[NotificationService] Deinit")
    }
}
