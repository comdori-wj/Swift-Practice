//
//  SettingViewController.swift
//  UserNotificationsPractice
//

import UIKit

final class SettingViewController: UIViewController {
    
    @IBOutlet var notificationTitle: UITextField!
    @IBOutlet var notificationBody: UITextField!
    @IBOutlet var secondBeforeNotification: UITextField!
    
    let center = UNUserNotificationCenter.current()
    
    @IBAction func sendLocalNotification(_ sender: UIButton) {
        center.getNotificationSettings { [weak self] setting in
            guard let self = self else { return }

            DispatchQueue.main.async {
                guard let timeString = self.secondBeforeNotification.text else { return }
                guard let time = Double(timeString) else {return}

                guard let title = self.notificationTitle.text, let body = self.notificationBody.text else { return }
                switch setting.authorizationStatus {
                case .authorized:
                    self.sendLocalNotification(title: title, body: body, second: time)
                default:
                    self.requestNotificationAuthorization() { granted in
                        guard granted else { print("사용자가 원하지 않는데요 😢"); return }
                        self.sendLocalNotification(title: title, body: body, second: time)
                    }
                }
            }
           
        }
    }
    
    private func requestNotificationAuthorization(completion: @escaping (Bool) -> Void) {
        center.requestAuthorization(
            options: [.alert, .sound, .badge, .criticalAlert]
        ) { granted, error in
            if let error = error { fatalError(error.localizedDescription) }
            completion(granted)
        }
    }
    
    private func sendLocalNotification(title: String, body: String, second: TimeInterval) {
        let contents = UNMutableNotificationContent()
        contents.title = title
        contents.body = body
        contents.badge = 1
        contents.sound = UNNotificationSound.defaultCritical
        contents.userInfo = ["noti" : title]
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: second, repeats: false)
        let identifier = "Done"
        let request = UNNotificationRequest(identifier: identifier, content: contents, trigger: trigger)
        
        center.add(request) { error in
            guard let error = error else { return }
            print(error)
        }
    }
}
