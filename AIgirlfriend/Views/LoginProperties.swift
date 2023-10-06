//
//  LoginProperties.swift
//  AIgirlfriend
//
//  Created by netset on 06/07/23.
//

import UIKit

//MARK: - Protocol
protocol LoginDelegates {

    func googleSignIn()
}

class LoginProperties: UIView {
    
    //MARK: - Variable Declaration
    var objLoginDelegates:LoginDelegates?
    
    // MARK: View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: IBActions
    @IBAction func actionBtnLoginWithGoogle(_ sender: UIButton) {
        objLoginDelegates?.googleSignIn()
    }
}
