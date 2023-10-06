//
//  CustomTabBarController.swift
//  AIgirlfriend
//
//  Created by netset on 07/07/23.
//

import UIKit
import GoogleSignIn

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = true
        showTabbar()
        delegate = self
    }
    
    //MARK: - Tabbar Delegate Method's
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        tabbarIndex = (viewControllers?.firstIndex(of: viewController))!
        if tabbarIndex == 2 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "LogoutVC") as! LogoutVC
            self.navigationController?.present(vc, animated: false)
            return false
        }
        return true
    }
    
    //MARK: - Custom Function
    func showTabbar() {
        self.tabBar.isHidden = false
    }
}



