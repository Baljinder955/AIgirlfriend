//
//  NoInternetVC.swift
//  AIgirlfriend
//
//  Created by netset on 05/10/23.
//

import UIKit

class NoInternetVC: UIViewController {
    
    @IBOutlet var vwProperties: NoInternetProperties!
    
    var callbackTryAgainBtn:(()->())?
        
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func btnActionTryAgain(_ sender: Any) {
        callbackTryAgainBtn?()
        self.dismiss(animated: true, completion: nil)
    }
    
}
