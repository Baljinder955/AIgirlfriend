//
//  AppInitializers.swift
//  AIattorney
//
//  Created by netset on 03/07/23.
//

import UIKit
import IQKeyboardManagerSwift

final class AppInitializers {
    
    static var shared: AppInitializers {
        return AppInitializers()
    }
    
    private init() {}
    
    func setupAppThings() {
        setupKeyboard()
        checkIfLogin()
    }
    
    private func setupKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.shouldToolbarUsesTextFieldTintColor = false
    }
    
    func checkIfLogin() {
        
        let isLogin = UserDefaults.standard.value(forKey: "isLogged")  as? Bool
        
        if isLogin == true {
            RootControllerProxy.shared.rootWithoutDrawer(ViewControllers.customTabBarController, storyboard: .main)
        } else {
            RootControllerProxy.shared.rootWithoutDrawer(ViewControllers.loginVC, storyboard: .main)
        }
    }
    
    func getCurrentViewController() -> UIViewController {
        let newVC = UIViewController()
        if let viewController = UIApplication.shared.windows.first?.rootViewController {
            return findTopViewController(viewController: viewController)
        }
        return newVC
    }
    
    func findTopViewController(viewController : UIViewController) -> UIViewController {
        if viewController is UITabBarController {
            let controller = viewController as! UITabBarController
            return findTopViewController(viewController: controller.selectedViewController!)
        } else if viewController is UINavigationController {
            let controller = viewController as! UINavigationController
            return findTopViewController(viewController: controller.visibleViewController!)
        }
        return viewController
    }
}
