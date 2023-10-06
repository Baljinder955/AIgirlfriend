//
//  LoginVCExt.swift
//  AIgirlfriend
//
//  Created by netset on 06/07/23.
//

import UIKit
import GoogleSignIn
import Alamofire

extension LoginVC : LoginDelegates {
    
    
    
    //    func gotoHomeVC() {
    //        print("Clicked")
    //            self.pushToViewController(storyBoard: .main, Identifier: ViewControllers.customTabBarController, animated: true)
    //    }
    
    //MARK: - Google Sign in
    func googleSignIn() {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { (googleUser, error) in
            if error != nil {
            } else {
                isLoggedIn = true
                let registration_type = "Google"
                let socialId = googleUser?.user.userID ?? ""
                let email_verified = "1"
                let firstName = googleUser?.user.profile?.name ?? ""
                let lastName = ""
                let email = googleUser?.user.profile?.email ?? ""
                CommonMethod.shared.showActivityIndicator()
                let userDataDict = ["registration_type":registration_type,"social_id":socialId,"firstName":firstName,"lastName":lastName,"email":email,"email_verified":email_verified] as [String:Any]
                UserDefaults.standard.set(userDataDict, forKey: "userData")
                UserDefaults.standard.set(isLoggedIn, forKey: "isLogged")
                let apiUrl = "\(baseURLs)api/v1/user/social-signup/"
                debugPrint("URL:- ",apiUrl)
                debugPrint("Param:- ",userDataDict)
                self.loginVM.callApiForLogin(url: apiUrl, param: userDataDict, vc: self) {
                    self.pushToViewController(storyBoard: .main, Identifier: ViewControllers.customTabBarController, animated: true)
                    CommonMethod.shared.hideActivityIndicator()
                }
            }
        }
    }
}

