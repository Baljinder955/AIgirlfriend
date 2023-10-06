//
//  LogoutVC.swift
//  AIgirlfriend
//
//  Created by netset on 24/07/23.
//

import UIKit

class LogoutVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet var vwProperties: LogoutProperties!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUIMethod()
    }
    
    //MARK: - Custom Function
    func prepareUIMethod(){
        vwProperties.objLogoutDelegate = self
    }
}
