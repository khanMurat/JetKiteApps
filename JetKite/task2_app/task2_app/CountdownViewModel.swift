//
//  CountdownViewModel.swift
//  task2_app
//
//  Created by Murat on 31.08.2023.
//

import UIKit

protocol CountDownViewModelDelegate : AnyObject {
    
    func updateButtonTitle(with title:String)
}

class CountdownViewModel {
    
    var currentTime: TimeInterval = 0
    
    var scheduledTimer: Timer?
    
    var delegate : CountDownViewModelDelegate?
    
    func startTimer(completion: @escaping (TimeInterval) -> Void) {
        if scheduledTimer == nil {
            guard currentTime > 0 else {return}
            scheduleNotification()
            scheduledTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if self.currentTime > 0 {
                    self.currentTime -= 1
                    completion(self.currentTime)
                    self.delegate?.updateButtonTitle(with: "Pause")
                } else {
                    self.resetTimer()
                    
                }
            }
        } else {
            pauseTimer()
            
        }
    }
    
    func pauseTimer() {
        scheduledTimer?.invalidate()
        scheduledTimer = nil
        self.delegate?.updateButtonTitle(with: "Start")
        removePendingNotifications()
    }
    
    func resetTimer() {
        pauseTimer()
        currentTime = 0
        self.delegate?.updateButtonTitle(with: "Start")
        removePendingNotifications()
    }
    
    func scheduleNotification() {
            let content = UNMutableNotificationContent()
            content.title = "END!"
            content.body = "Timer has elapsed."
            content.sound = UNNotificationSound(named: UNNotificationSoundName("wakeup_alarm.caf"))
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: currentTime, repeats: false)
            
            let request = UNNotificationRequest(identifier: "alarm", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
               print("success")
            }
        }
        
        func removePendingNotifications() {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["alarm"])
        }
}
