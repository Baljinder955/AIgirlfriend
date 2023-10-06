//
//  CommonEnumFile.swift
//  AIattorney
//
//  Created by netset on 03/07/23.
//

import Foundation

//MARK: - Storyboard Name
enum Storyboards: String {
    case main = "Main"
}

//MARK: - View Controller's with ID
enum ViewControllers {
    static let loginVC = "LoginVC"
    static let homeVC = "HomeVC"
    static let customTabBarController = "CustomTabBarController"
    static let profileVC = "ProfileVC"
    static let messageVC = "MessagesVC"
    static let imgVwVC = "ImgVwVC"
}

//MARK: - Header Title
enum HeaderTitle {
    static let contactUs = "Contact Us"
    static let myGirlfriends = "My Girlfriends"
}

enum TextAlign {
    static let center = "C"
    static let left = "L"
}

//MARK: - Parameters
enum Param {
    static let contentType = "content-type"
    static let deviceId = "device-id"
    static let deviceType = "device-type"
    static let appVersion = "app-version"
    static let auth = "Authorization"
    static let appJson = "application/json"
    static let ios = "ios"
}
