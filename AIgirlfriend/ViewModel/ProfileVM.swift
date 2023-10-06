//
//  ProfileVM.swift
//  AIgirlfriend
//
//  Created by netset on 05/09/23.
//

import Foundation
import UIKit


class ProfileVM {
    
    //MARK: - Get UserList API Method
    func getChatListData(user_id:String,vc:UIViewController, completion:@escaping(MessageDataModel?)->()) {
        WebServices.getRequest(url: "https://onlyfantasy-api.ecomempire.in/api/v1/user/get-creator/\(user_id)", viewController: vc, view: vc.view, shouldAnimateHudd: true) { (responseObject) in
            do {
                let decoder = JSONDecoder()
                let apiData = try decoder.decode(ProfileModel.self, from: responseObject)
                completion(apiData.message)
            } catch {
                print("Decoding Error:", error.localizedDescription)
            }
        }
    }
}



