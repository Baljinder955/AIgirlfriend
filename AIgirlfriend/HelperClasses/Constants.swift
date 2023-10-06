//
//  Constants.swift
//  AIgirlfriend
//
//  Created by netset on 25/08/23.
//

import Foundation
import SocketRocket

//MARK: - Constants
let token = "token"

var deviceTokenSaved:String {
    set {
        UserDefaults.standard.set(newValue, forKey: "device_token")
        UserDefaults.standard.synchronize()
    }
    get {
        return UserDefaults.standard.string(forKey: "device_token") ?? ""
    }
}

enum Appinfo {
    static  var appName = "AIgirlfriend"
}



