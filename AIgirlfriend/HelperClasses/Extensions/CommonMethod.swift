//
//  CommonMethod.swift
//  AIgirlfriend
//
//  Created by netset on 15/09/23.
//

import Foundation
import NVActivityIndicatorView

class CommonMethod {
    
    static var shared: CommonMethod {
        return CommonMethod()
    }
    fileprivate init(){}
    
    //MARK:- Show Activity Indicator Method
    func showActivityIndicator() {
        DispatchQueue.main.async {
            let activityData = ActivityData(type:.lineScale, color: .orange)
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        }
    }
    
    //MARK:- Hide Activity Indicator Method
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        }
    }
}
