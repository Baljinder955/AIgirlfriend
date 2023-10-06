//
//  UIViewControllerExtension.swift
// BaseApp
//
//  Created by netset on 12/12/22.
//

import UIKit

extension UIViewController: UINavigationBarDelegate {
    
    func checkAndPopToController <T : UIViewController>(with : T) -> T? {
        for vc in self.navigationController?.children ?? [] {
            if vc is T {
                return vc as? T
            }
        }
        return nil
    }
    
    func popViewController(_ animated: Bool) {
        self.navigationController?.popViewController(animated: animated)
    }
    
    func popToRootViewController(_ animated: Bool) {
        self.navigationController?.popToRootViewController(animated: animated)
    }
    
    func pushToViewController(storyBoard: Storyboards, Identifier: String,animated: Bool) {
        let viewController = getStoryboard(storyBoard).instantiateViewController(withIdentifier: Identifier)
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func presentToViewController(storyBoard: Storyboards, Identifier: String,animated: Bool) {
        let viewController = getStoryboard(storyBoard).instantiateViewController(withIdentifier: Identifier)
        self.present(viewController, animated: animated, completion: nil)
    }
    
    // MARK: - Dismiss Keyboard
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
