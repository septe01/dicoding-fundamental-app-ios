import UIKit
import SystemConfiguration

var greeting = "Implementasi Reachability"


func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
    let isReachable = flags.contains(.reachable)
    let needConnection = flags.contains(.connectionRequired)
    let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
    let canConnectWithoutUserInteraction =  canConnectAutomatically && !flags.contains(.interventionRequired)
    
    
    
    return isReachable && (!needConnection || canConnectWithoutUserInteraction)
}


let reachable = SCNetworkReachabilityCreateWithName(nil, "dfgsdfg")

var flags = SCNetworkReachabilityFlags()

SCNetworkReachabilityGetFlags(reachable!, &flags)

if !isNetworkReachable(with: flags){
    print("Device doesn't have internet connection.")
}else{
    print("Host www.dicoding.com is Reachable.")
}
