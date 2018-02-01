//
//  NotificationManager.swift
//  Egg Timer
//
//  Created by Martijn van Gogh on 01-02-18.
//  Copyright © 2018 Martijn van Gogh. All rights reserved.
//

import Foundation
import UserNotifications

enum LocalNotification {
    case Zacht
    case ZachtMedium
    case Medium
    case MediumHard
    case Hard

    var title: String {
        switch self {
        case .Zacht:
            return "notification.title.zacht".localized
        case .ZachtMedium:
            return "notification.title.zachtmedium".localized
        case .Medium:
            return "notification.title.medium".localized
        case .MediumHard:
            return "notification.title.mediumhard".localized
        case .Hard:
            return "notification.title.hard".localized
        }
    }

    var body: String {
        switch self {
        case .Zacht:
            return "notification.body.zacht".localized
        case .ZachtMedium:
            return "notification.body.zachtmedium".localized
        case .Medium:
            return "notification.body.medium".localized
        case .MediumHard:
            return "notification.body.mediumhard".localized
        case .Hard:
            return "notification.body.hard".localized
        }
    }
}

final class NotificationManager: NSObject {

    static let shared = NotificationManager()

    // Asks for authorization the first time the app is used
    func requestAuthorization(completionHandler: @escaping (_ succes: Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (succes, error) in
            if let error = error {
                print("Request Authorization Failed (\(error), \(error.localizedDescription))")
            }
            completionHandler(succes)
        }
    }

    func scheduleNotification(notificationCase: LocalNotification, firedate: TimeInterval) {
        UNUserNotificationCenter.current().getNotificationSettings { (notificationSettings) in
            switch notificationSettings.authorizationStatus {

            case .notDetermined:
                self.requestAuthorization(completionHandler: { (success) in
                    guard success else { return }

                    self.scheduleLocalNotification(notificationCase: notificationCase, firedate: firedate)
                })
            case .authorized:

                self.scheduleLocalNotification(notificationCase: notificationCase, firedate: firedate)

            case .denied:
                print("Application Not Allowed to Display Notifications")
            }
        }
    }

    // Schedules the next notification with a title, subtitle, body and sound
    private func scheduleLocalNotification(notificationCase: LocalNotification, firedate: TimeInterval) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = notificationCase.title
        notificationContent.body = notificationCase.body
        notificationContent.sound = UNNotificationSound(named: "eggsready.wav")

        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: firedate, repeats: false)
        let notificationRequest = UNNotificationRequest(identifier: "Notification_eggready", content: notificationContent, trigger: notificationTrigger)

        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        }
    }

}
