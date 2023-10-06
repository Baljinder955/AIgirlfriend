//
//  InternetReachability.swift
//  AIgirlfriend
//
//  Created by netset on 28/08/23.
//

import Foundation
import UIKit
import SystemConfiguration

class InternetReachability {
    
    static let sharedInstance = InternetReachability()
    
    // MARK: INTERNET AVAILABLITY Method
    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired
        return (isReachable && !needsConnection)
    }
}
