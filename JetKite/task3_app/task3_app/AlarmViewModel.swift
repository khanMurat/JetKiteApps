//
//  AlarmViewModel.swift
//  task3_app
//
//  Created by Murat on 29.08.2023.
//

import UserNotifications
import UIKit

class AlarmViewModel {
    
    var selectedHour: Int = 0
    
    var selectedMinute: Int = 0
    
    
    func setAlarm(hour: Int, minute: Int, completion: @escaping (Bool, Error?) -> Void) {
        let calendar = Calendar.current
        let now = Date()
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        if let alarmDate = calendar.date(bySettingHour: hour, minute: minute, second: 0, of: now), alarmDate <= now {
            dateComponents.day = calendar.component(.day, from: now) + 1
        }
        
        let content = UNMutableNotificationContent()
        content.title = "ALARM!"
        content.body = "Wake up."
        content.sound = UNNotificationSound(named: UNNotificationSoundName("wakeup_alarm.caf"))
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "alarm", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            completion(error == nil, error)
        }
    }
}
