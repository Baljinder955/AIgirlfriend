//
//  ProfileVC.swift
//  AIgirlfriend
//
//  Created by netset on 12/07/23.
//

import UIKit

class ProfileVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet var vwProperties: ProfileProperties!

    //MARK: - Variables Declaration
    var objHomeDataModel:HomeBaseModel?
    var userId = String()
    var objProfileVM = ProfileVM()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = true
        prepareUIMethod()
    }
    
    //MARK: - Custom Function
    private func prepareUIMethod() {
        self.userId = objHomeDataModel != nil ? (objHomeDataModel?.id ?? "") : DataManager.userIdSaved
        vwProperties.objProfileDelegate = self
        vwProperties.showUserDetailMethod(objHomeDataModel)
        if objHomeDataModel != nil {
            vwProperties.vwChatNow.isHidden = false
        } else {
            vwProperties.vwChatNow.isHidden = true
        }
        objProfileVM.getChatListData(user_id: self.userId, vc: self) { (messageModel) in
            self.vwProperties.prepareUIMethod(dataDetailed: messageModel)
        }
    }
}
