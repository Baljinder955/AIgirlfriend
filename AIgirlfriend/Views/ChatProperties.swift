//
//  ChatProperties.swift
//  AIgirlfriend
//
//  Created by netset on 12/07/23.
//

import UIKit

//MARK: - Protocol
protocol ChatDelegate{
    func didSelectTblVW()
}


class ChatProperties: UIView {
    
    //MARK: - IBOutlet's
    @IBOutlet weak var chatTableVw: UITableView!
    @IBOutlet weak var btnAutoPlay: UISwitch!
    
    //MARK: Variable Declaration
    var objChatDelegate:ChatDelegate?
    var objChatVM = ChatVM()
    
    //MARK: - View Life Cycle
    override class func awakeFromNib() {
        super.awakeFromNib()
    }

}
