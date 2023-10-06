//
//  SplashVC.swift
//  AIgirlfriend
//
//  Created by netset on 06/07/23.
//

import Foundation
import UIKit

class SplashVC:UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sleep(1)
        AppInitializers.shared.setupAppThings()
    }
    
}
