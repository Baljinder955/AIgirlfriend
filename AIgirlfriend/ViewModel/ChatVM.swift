//
//  ChatVM.swift
//  AIgirlfriend
//
//  Created by netset on 12/07/23.
//

import Foundation
import UIKit


class ChatVM : NSObject {
    
    var chatDataList:[ChatList]?
    
    //MARK: - Get UserList API Method
    func getChatListData(vc:UIViewController, completion:@escaping ()->()){
        WebServices.getRequest(url: "https://onlyfantasy-api.ecomempire.in/api/v1/chat/chat-list", viewController: vc, view: vc.view, shouldAnimateHudd: true) { (responseObject) in
            do {
                let decoder = JSONDecoder()
                let apiData = try decoder.decode(ChatDataListModel.self, from: responseObject)
                self.chatDataList = apiData.message?.chatList
                print("Decoded API Data:", apiData)
                completion()
            } catch {
                print("Decoding Error:", error)
            }
        }
    }
    
    func toggleButtonPressedApiMethod(apiUrl: String, vc: UIViewController, param: [String: Any], completion: @escaping () -> ()) {
        WebServices.putRequest(url: apiUrl, viewController: vc, view: vc.view, parameters: param, shouldAnimateHUD: true) { responseObject in
            completion()
        }
    }
}
