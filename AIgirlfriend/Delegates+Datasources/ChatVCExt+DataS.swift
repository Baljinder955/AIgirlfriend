//
//  CollectonViewDelegateMethods.swift
//  AIgirlfriend
//
//  Created by netset on 07/07/23.
//

import Foundation
import UIKit

//MARK: - TableView DataSources
class ChatDataSource: NSObject, UITableViewDataSource {
    
    private let viewModel:ChatVM!
    init(viewModel: ChatVM!) {self.viewModel = viewModel}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.chatDataList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ChatTVC
        cell.selectionStyle = .none
        let data = viewModel.chatDataList?[indexPath.row]
        cell.lblUserName.text = data?.characterObj?.name ?? ""
        let imgUrl = URL(string: "https://onlyfantasy-ai.ecomempire.in/media/characters/\(data?.characterObj?.image ?? "")")
        cell.imgUser.sd_setImage(with: imgUrl, placeholderImage: UIImage(named: "ic-user"))
        return cell
    }
}

//MARK: - TableView Delegates
class ChatDelegates:NSObject,UITableViewDelegate {
    
    private let viewModel:ChatVM!
    var callBackDidSeclect:((_ detailsDict:ChatList?)->())?
    init(viewModel: ChatVM!) {self.viewModel = viewModel}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedName = viewModel.chatDataList?[indexPath.row]
        self.callBackDidSeclect?(selectedName)
    }
}
