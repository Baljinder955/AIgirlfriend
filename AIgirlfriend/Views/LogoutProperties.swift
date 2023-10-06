//
//  logoutProperties.swift
//  AIgirlfriend
//
//  Created by netset on 26/07/23.
//

import UIKit

//MARK: - Protocol
protocol LogoutDelgates {
    func yesLogout()
    func noLogout()
}

class LogoutProperties: UIView {
    
    // MARK: Variable Declartion
    var objLogoutDelegate:LogoutDelgates?
    
    //MARK: IBAction's
    @IBAction func btnActionYes(_ sender: Any) {
        objLogoutDelegate?.yesLogout()
    }
    
    @IBAction func btnActionNo(_ sender: Any) {
        objLogoutDelegate?.noLogout()
    }
}
