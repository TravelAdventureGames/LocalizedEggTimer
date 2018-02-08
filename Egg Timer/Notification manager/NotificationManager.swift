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

    var bodyMultiple: String {
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

    var bodySingle: String {
        switch self {
        case .Zacht:
            return "notification.body.zachtSingle".localized
        case .ZachtMedium:
            return "notification.body.zachtmediumSingle".localized
        case .Medium:
            return "notification.body.mediumSingle".localized
        case .MediumHard:
            return "notification.body.mediumhardSingle".localized
        case .Hard:
            return "notification.body.hardSingle".localized
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

    func scheduleNotification(notificationCase: LocalNotification, firedate: TimeInterval, identifier: String, eggAmount: Int) {
        UNUserNotificationCenter.current().getNotificationSettings { (notificationSettings) in
            switch notificationSettings.authorizationStatus {

            case .notDetermined:
                self.requestAuthorization(completionHandler: { (success) in
                    guard success else { return }

                    self.scheduleLocalNotification(notificationCase: notificationCase, firedate: firedate, identifier: identifier, eggAmount: eggAmount)
                })
            case .authorized:

                self.scheduleLocalNotification(notificationCase: notificationCase, firedate: firedate, identifier: identifier, eggAmount: eggAmount)

            case .denied:
                print("Application Not Allowed to Display Notifications")
            }
        }
    }

    func cancelAllPendingNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    // Schedules the next notification with a title, subtitle, body and sound
    private func scheduleLocalNotification(notificationCase: LocalNotification, firedate: TimeInterval, identifier: String, eggAmount: Int) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = notificationCase.title
        let bodyTextFirst = "notification.body.first".localized
        var bodyTextSecond: String
        if eggAmount == 1 {
            bodyTextSecond = notificationCase.bodySingle
        } else {
            bodyTextSecond = notificationCase.bodyMultiple
        }
        let BodyText = "\(bodyTextFirst) \(eggAmount) \(bodyTextSecond)"
        notificationContent.body = BodyText//notificationCase.body
        notificationContent.sound = UNNotificationSound(named: "eggsready.wav")

        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: firedate, repeats: false)
        let notificationRequest = UNNotificationRequest(identifier: identifier, content: notificationContent, trigger: notificationTrigger)

        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        }
    }



}
