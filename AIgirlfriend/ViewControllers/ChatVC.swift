//
//  ChatVC.swift
//  AIgirlfriend
//
//  Created by netset on 12/07/23.
//

import UIKit

class ChatVC: UIViewController {
    
    //MARK: - IBOutlet's
    @IBOutlet var vwProperties: ChatProperties!
    
    //MARK: Variable Declaration
    var objChatVM = ChatVM()
    var user_id = String()
    var isStatus = Bool()
    private let refreshControl = UIRefreshControl()
    private var delegate: ChatDelegates!
    private var dataSource: ChatDataSource!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = true
        prepareUIMethod()
        initializeViewDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        vwProperties.btnAutoPlay.isOn = DataManager.isMessageAutoPlay
        getChatUserListApiMethod()
        vwProperties.btnAutoPlay.addTarget(self, action: #selector(actionPerfomed(_:)), for: .valueChanged)
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        vwProperties.chatTableVw.refreshControl = refreshControl
        refreshControl.tintColor = .orange
    }
    
    //MARK: DataSource + Delegates
    func initializeViewDataSource(){
        dataSource = ChatDataSource(viewModel: objChatVM)
        delegate = ChatDelegates(viewModel: objChatVM)
        vwProperties.chatTableVw.dataSource = dataSource
        vwProperties.chatTableVw.delegate = delegate
        vwProperties.chatTableVw.reloadData()
        delegate.callBackDidSeclect = { (detailDict) in
            let viewController = getStoryboard(.main).instantiateViewController(withIdentifier: ViewControllers.messageVC) as! MessagesVC
            viewController.objMessagesVM.characterId = (detailDict?.character ?? "")
            viewController.objMessagesVM.otherCharName = (detailDict?.characterObj?.name ?? "")
            viewController.objMessagesVM.isAutoPlayMessage = DataManager.isMessageAutoPlay
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    //MARK: - Custom Function
    
    @objc private func refreshData(_ sender: Any) {
        getChatUserListApiMethod()
        refreshControl.endRefreshing()
    }
    
    private func prepareUIMethod() {
        vwProperties.objChatDelegate = self
    }
    
    @objc func actionPerfomed(_ sender: UISwitch){
        if sender.isOn {
            let apiUrl = "https://onlyfantasy-api.ecomempire.in/api/v1/user/message-status/"
            let param = ["status": 1]
            objChatVM.toggleButtonPressedApiMethod(apiUrl: apiUrl, vc: self, param: param) {
                DataManager.isMessageAutoPlay = !DataManager.isMessageAutoPlay
            }
        } else {
            let apiUrl = "https://onlyfantasy-api.ecomempire.in/api/v1/user/message-status/"
            let param = ["status": 0]
            objChatVM.toggleButtonPressedApiMethod(apiUrl: apiUrl, vc: self, param: param) {
                DataManager.isMessageAutoPlay = !DataManager.isMessageAutoPlay
            }
        }
    }
}
