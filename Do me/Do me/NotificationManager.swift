//
//  NotificationManager.swift
//  Do me
//
//  Created by Yavuz Selim Bitmez on 30.09.2021.
//

import Foundation
import UserNotifications

class NotificationManager {

    static let shared = NotificationManager()
    // MARK: - Properties
    let center = UNUserNotificationCenter.current()

    func addNotification(task:TaskModel,date:Date){
        
        let content = UNMutableNotificationContent()
        content.title = task.header
        content.body = task.context
        content.sound = UNNotificationSound.default
        let identifier = "\(task.id)"
        let date = date
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)

        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)

        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        center.add(request) { (error) in
            if error != nil {
                print("Something wrong")
            }
        }
    }
    
    func removeNotification(task:TaskModel){
        center.removePendingNotificationRequests(withIdentifiers: ["\(task.id)"])
    }

}
