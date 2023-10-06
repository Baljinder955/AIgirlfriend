//
//  LogoutVCExt.swift
//  AIgirlfriend
//
//  Created by netset on 26/07/23.
//

import Foundation
import UIKit
import GoogleSignIn

extension LogoutVC : LogoutDelgates {
    
    //MARK: - Google Logout
    func yesLogout() {
        GIDSignIn.sharedInstance.signOut()
        isLoggedIn = false
        UserDefaults.standard.removeObject(forKey: "userData")
        UserDefaults.standard.set(isLoggedIn, forKey: "isLogged")
        RootControllerProxy.shared.rootWithoutDrawer(ViewControllers.loginVC, storyboard: .main)
    }
    
    func noLogout() {
        self.dismiss(animated: false)
    }
}
