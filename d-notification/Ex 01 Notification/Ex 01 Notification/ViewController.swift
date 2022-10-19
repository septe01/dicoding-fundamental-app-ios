//
//  ViewController.swift
//  Ex 01 Notification
//
//  Created by septe habudin on 19/10/22.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        UNUserNotificationCenter.current().delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        UNUserNotificationCenter.current().requestAuthorization(
          options: [.alert, .badge, .sound]
        ) { (granted, _) in
          if granted {
            print("Mendapatkan izin dari pengguna untuk local notifications")


          } else {
            print("Tidak mendapatkan izin dari pengguna untuk local notifications")
          }
        }
    }


    @IBAction func scheduleNotification(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.title = "Submission Anda Telah Diterima!"
        content.body = "Selamat Anda telah menyelesaikan kelas Belajar Fundamental Aplikasi iOS."
        content.sound = .default
        content.userInfo = ["value": "Data dengan local notification"]

        let fireDate = Calendar.current.dateComponents(
          [.day, .month, .year, .hour, .minute, .second],
          from: Date().addingTimeInterval(10)
        )

        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDate, repeats: false)

        let request = UNNotificationRequest(identifier: "message", content: content, trigger: trigger)

        let center = UNUserNotificationCenter.current()
        center.add(request) { error in
          if error != nil {
            print("Error = \(error?.localizedDescription ?? "Terjadi kesalahan dalam local notification")")
          }
        }
    }
}

//Menambahkan Delegation UNUserNotificationCenter
extension ViewController: UNUserNotificationCenterDelegate {
  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    completionHandler([.badge, .badge, .sound])
  }

  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void
  ) {
    print("UserInfo yang terkait dengan notifikasi == \(response.notification.request.content.userInfo)")
    completionHandler()
  }
}

