//
//  LoginVM.swift
//  AIgirlfriend
//
//  Created by netset on 07/07/23.
//

import Foundation
import UIKit

class LoginVM {
    
    var loginBaseData:loginBase?
    
    //MARK: - Login API Method
    
    func callApiForLogin(url:String, param:[String:Any], vc:UIViewController, completion:@escaping()->()){
        WebServices.postRequest(url: url, VwController: vc, view: vc.view, param: param, method: .post, shouldAnimateHudd: false) { responseObject in
            let apiData = JSONDecoder().decode(model: LoginDataModel.self, data: responseObject)
            self.loginBaseData = apiData?.data?.saveData
            DataManager.userFirstName = apiData?.data?.saveData?.firstName ?? ""
            DataManager.userIdSaved = apiData?.data?.saveData?._id ?? ""
            DataManager.accessToken = apiData?.data?.token ?? ""
            DataManager.isMessageAutoPlay = apiData?.data?.saveData?.message_autoplay ?? false
            completion()
        }
    }
}
