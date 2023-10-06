//
//  ProfileVCExt+DataS.swift
//  AIgirlfriend
//
//  Created by netset on 17/07/23.
//

import Foundation
import UIKit

extension ProfileVC:ProfileDelegates {
    
    //MARK: - Custom Functions
    func popToBack() {
        self.popViewController(true)
    }
    
    // MARK: - Navigation Function
    func gotoChat() {
        let viewController = getStoryboard(.main).instantiateViewController(withIdentifier: ViewControllers.messageVC) as! MessagesVC
        viewController.objMessagesVM.characterId = objHomeDataModel?.id ?? ""
        viewController.objMessagesVM.otherCharName = objHomeDataModel?.name ?? ""
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

