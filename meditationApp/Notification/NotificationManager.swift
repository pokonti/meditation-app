//
//  NotificationManager.swift
//  meditationApp
//
//  Created by Firuza on 06.05.2025.
//

import Foundation
import UserNotifications

final class NotificationManager {
    static let shared = NotificationManager()
    private init() {}

    /// Запрос разрешения у пользователя
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]
        ) { granted, error in
            if let error = error {
                print("Notification auth error:", error)
            }
        }
    }

  
    func scheduleTestReminder() {
        let content = UNMutableNotificationContent()
        content.title = "Diary Reminder"
        content.body  = "Don't forget to write in your diary!"
        content.sound = .default

       
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        let request = UNNotificationRequest(
            identifier: "diary_test_reminder",
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request)
    }

    /// Ежедневное напоминание в заданное время
    func scheduleDailyReminder(hour: Int, minute: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Diary Reminder"
        content.body  = "How was your day? Share in your diary."
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour   = hour
        dateComponents.minute = minute

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: true
        )
        let request = UNNotificationRequest(
            identifier: "diary_evening_reminder",
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request)
    }
}
