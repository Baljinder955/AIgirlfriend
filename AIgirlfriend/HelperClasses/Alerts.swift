//
//  Alerts.swift
//  AIgirlfriend
//
//  Created by netset on 06/09/23.
//

import Foundation
import UIKit

class Alerts {
    
    static let shared = Alerts()
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        let getController = AppInitializers.shared.getCurrentViewController()
        DispatchQueue.main.async {
            if let _ = getController.presentingViewController {
                getController.present(alert, animated: true, completion: nil)
            } else {
                UIWindow.key.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func alertMessageWithActionOk(title: String, message: String,action:@escaping ()->()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Okay", style: .default) { (result : UIAlertAction) -> Void in
            action()
        }
        alert.addAction(action)
        let getController = AppInitializers.shared.getCurrentViewController()
        DispatchQueue.main.async {
            if let _ = getController.presentingViewController {
                getController.present(alert, animated: true, completion: nil)
            } else {
                UIWindow.key.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func alertMessageWithActionOkAndCancel(title: String, message: String,action:@escaping ()->()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let actionOk = UIAlertAction(title: "Okay", style: .default) { (result : UIAlertAction) -> Void in
            action()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (result : UIAlertAction) -> Void in
        }
        alert.addAction(actionOk)
        alert.addAction(cancel)
        let getController = AppInitializers.shared.getCurrentViewController()
        DispatchQueue.main.async {
            if let _ = getController.presentingViewController {
                getController.present(alert, animated: true, completion: nil)
            } else {
                UIWindow.key.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func alertMessageWithActionOkAndCancelYesNo(title: String, message: String,action:@escaping ()->()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let actionOk = UIAlertAction(title: "Yes", style: .default) { (result : UIAlertAction) -> Void in
            action()
        }
        let cancel = UIAlertAction(title: "No", style: .default) { (result : UIAlertAction) -> Void in
        }
        alert.addAction(actionOk)
        alert.addAction(cancel)
        let getController = AppInitializers.shared.getCurrentViewController()
        DispatchQueue.main.async {
            if let _ = getController.presentingViewController {
                getController.present(alert, animated: true, completion: nil)
            } else {
                UIWindow.key.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
}
