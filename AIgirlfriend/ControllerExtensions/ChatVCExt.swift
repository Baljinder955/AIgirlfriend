//
//  ChatVCExt.swift
//  AIgirlfriend
//
//  Created by netset on 12/07/23.
//

import Foundation
import UIKit

extension ChatVC:ChatDelegate {
    
    func didSelectTblVW() {
    }
    
    //MARK: - Api Implement
    func getChatUserListApiMethod(){
        
        if InternetReachability.sharedInstance.isInternetAvailable() {
            objChatVM.getChatListData(vc: self) {
                self.vwProperties.chatTableVw.reloadData()
            }
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "NoInternetVC") as! NoInternetVC
            vc.callbackTryAgainBtn = {
                debugPrint("call back is working properly")
                self.getChatUserListApiMethod()
            }
            navigationController?.pushViewController(vc, animated: false)
            debugPrint("no internet")
        }
    }
}
