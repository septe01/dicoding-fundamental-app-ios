//
//  ViewController.swift
//  Ex 01 Implementasi Reachability
//
//  Created by septe habudin on 21/09/22.
//

import UIKit
import SystemConfiguration

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func checkReachability(_ sender: Any) {
        let reachable = SCNetworkReachabilityCreateWithName(nil, "www.stiacourse.com")

        var flags = SCNetworkReachabilityFlags()

        SCNetworkReachabilityGetFlags(reachable!, &flags)

        if !isNetworkReachable(with: flags){
            print("Device doesn't have internet connection.")
        }else{
            print("Host www.dicoding.com is Reachable.")
        }
        
        // if os(IOS)
        if flags.contains(.isWWAN){
            print("device is using mobile data.")
        }
        
    }
    
    
    func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        print("isReachable\(isReachable)")
        let needConnection = flags.contains(.connectionRequired)
        print("needConnection\(needConnection)")
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        print("canConnectAutomatically\(canConnectAutomatically)")
        let canConnectWithoutUserInteraction =  canConnectAutomatically && !flags.contains(.interventionRequired)
        print("canConnectAutomatically\(canConnectWithoutUserInteraction)")
        
        
        
        return isReachable && (!needConnection || canConnectWithoutUserInteraction)
    }
    
}

