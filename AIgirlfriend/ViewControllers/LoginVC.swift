//
//  LoginVC.swift
//  AIgirlfriend
//
//  Created by netset on 06/07/23.
//

import UIKit
import GoogleSignIn


class LoginVC: UIViewController {
    
    //MARK: - variable declaration
    var loginBase:loginBase?
    
    //MARK: IBOutlets
    @IBOutlet var vwProperties: LoginProperties!
    
    //MARK: Variable declaration
    var loginVM = LoginVM()
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = true
        prepareUIMethod()
    }
    
    //MARK: - Custom Function
    private func prepareUIMethod() {
        vwProperties.objLoginDelegates = self
    }
}
