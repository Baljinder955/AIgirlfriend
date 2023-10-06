//
//  DataManager.swift
//  AIgirlfriend
//
//  Created by netset on 28/08/23.
//

import Foundation


class DataManager {
    
    //MARK: - Access Token
    static var accessToken:String {
        set {
            UserDefaults.standard.set(newValue, forKey: token)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: token) ?? ""
        }
    }
    
    // MARK: - User First Name
    static var userFirstName:String {
        set {
            UserDefaults.standard.set(newValue, forKey: "user_first_name")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: "user_first_name") ?? ""
        }
    }
    
    // MARK: - User First Name
    static var userIdSaved:String {
        set {
            UserDefaults.standard.set(newValue, forKey: "login_user_id")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: "login_user_id") ?? ""
        }
    }
    
    
    static var messageid:String {
        set {
            UserDefaults.standard.set(newValue, forKey: "message_id")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: "message_id") ?? ""
        }
    }
    
    static var isMessageAutoPlay:Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: "message_autoplay")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.bool(forKey: "message_autoplay")
        }
    }
}

