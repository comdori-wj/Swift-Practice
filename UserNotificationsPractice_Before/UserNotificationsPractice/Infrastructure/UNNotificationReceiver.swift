//
//  UNNotificationReceiver.swift
//  UserNotificationsPractice
//

import NotificationCenter

final class UNNotificationReceiver: NSObject {
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
}

extension UNNotificationReceiver: UNUserNotificationCenterDelegate {
    
    
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound, .badge, .list])
        // completionHandler([.banner])
        // 둘이 바꿔치기도 해보세요~
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        print("didReceive - identifier: \(response.notification.request.identifier)")
        print("didReceive - UserInfo: \(response.notification.request.content.userInfo)")
        
        if response.notification.request.identifier == "Done" {
//            let keyWindow = UIApplication.shared.connectedScenes
//                .filter({$0.activationState == .foregroundActive})
//                .map({$0 as? UIWindowScene})
//                .compactMap({$0})
//                .first?.windows
//                .filter({$0.isKeyWindow}).first
            
//            let topVC = keyWindow?.rootViewController as? UITabBarController
            //            UIApplication.shared.keyWindow?.rootViewController as? UITabBarController
            //            let innerViewController = InnerViewController()

//            topVC?.selectedIndex = 1
            //                .navigationController?.pushViewController(innerViewController, animated: true)
            
        }
        
        let title = response.notification.request.content.title
        let body = response.notification.request.content.body
        
        let rootView = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController as? UITabBarController
        rootView?.selectedIndex = 1
        let navi = rootView?.selectedViewController as? UINavigationController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let innerViewController = storyboard.instantiateViewController(identifier: "InnerViewController") as? InnerViewController else { return }
        
        innerViewController.loadViewIfNeeded()
        innerViewController.notificationTitle.text = title
        innerViewController.notificationBody.text = body
        
        navi?.pushViewController(innerViewController, animated: true)
        
        completionHandler()
    }
}
