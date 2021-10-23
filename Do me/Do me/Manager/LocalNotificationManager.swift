//
//  NotificationManager.swift
//  Do me
//
//  Created by Yavuz Selim Bitmez on 30.09.2021.
//

import Foundation
import UserNotifications

class LocalNotificationManager {

    static let shared = LocalNotificationManager()
    // MARK: - Properties
    let center = UNUserNotificationCenter.current()
    func addNotification(task:TaskModel){
        
        let content = UNMutableNotificationContent()
        content.title = task.header
        content.body = task.content
        content.sound = UNNotificationSound.default
        let identifier = "0"
        let date = task.date
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        center.add(request) { (error) in
            if error != nil {
                NSLog("[NotificationManager] Added Notification %@", error.debugDescription)
            }
        }
        NSLog("[NotificationManager] Added Notification")

    }
    func removeNotification(task:DetailPresentation){
        center.removePendingNotificationRequests(withIdentifiers: ["0"])
        NSLog("[NotificationManager] Removed Notification")

    }
    deinit {
        NSLog("[LocalNotificationManager] Deinit")
    }
}
