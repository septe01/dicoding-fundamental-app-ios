//
//  AppDelegate.swift
//  Ex 11 Latihan Membagikan File Data
//
//  Created by septe habudin on 25/09/22.
//

import UIKit


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller = ViewController()

    let navigation = UINavigationController(rootViewController: controller)

    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = navigation
    window?.makeKeyAndVisible()

    return true
  }

  func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey: Any] = [:]
  ) -> Bool {
    guard url.pathExtension == "dicoding",
          let data = try? Data(contentsOf: url),
          let navigation = window?.rootViewController as? UINavigationController
    else { return false }

    let controller = ResultViewController(data: data)

    navigation.pushViewController(controller, animated: true)

    try? FileManager.default.removeItem(at: url)

    return true
  }
}


//@main
//class AppDelegate: UIResponder, UIApplicationDelegate {
//    var window: UIWindow?
//
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//
//        let controller = ViewController()
//        let navigation = UINavigationController(rootViewController: controller)
//
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = navigation
//        window?.makeKeyAndVisible()
//
//        return true
//    }
//
//    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }
//
//    // add this function to handle accept file
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//
//        guard url.pathExtension == "dicoding", let data = try? Data(contentsOf: url), let navigation = window?.rootViewController as? UINavigationController else { return false }
//
////        Inisialisasi ResultViewControllerdan kirim data sebagai parameter
//        let controller = ResultViewController(data: data)
//
//        navigation.pushViewController(controller, animated: true)
//
////        Hapus file yang sudah berhasil ditampilkan. Hal ini penting untuk dilakukan karena jika tidak, setiap file yang kita terima akan terus disimpan dan mengakibatkan ukuran aplikasi kita menjadi semakin besar
//        try? FileManager.default.removeItem(at: url)
//
//        return true
//    }
//
//
//}

