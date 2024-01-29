//
//  InnerViewController.swift
//  UserNotificationsPractice
//

import UIKit

final class InnerViewController: UIViewController {
    @IBOutlet weak var notificationTitle: UILabel!
    @IBOutlet weak var notificationBody: UILabel!
    
    override func viewDidLoad() {
//        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNoti), name: Notification.Name("Done"), object: nil)
        print("ㅇㅇ")
        // Do any additional setup after loading the view.
    }

    
    @objc func receiveNoti(_ noti: Notification) {
        guard let title = noti.userInfo?[AnyHashable("noti")] as? String else { return }
        print("제목:",title)
        notificationTitle.text = title
    }
}
