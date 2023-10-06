//
//  MessagesSenderTVC.swift
//  AIgirlfriend
//
//  Created by netset on 17/07/23.
//

import UIKit

class MessagesSenderTVC: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var lblSenderUserName: UILabel!
    @IBOutlet weak var lblSenderUserMessage: UILabel!
    @IBOutlet weak var lblUserMessageSendTime: UILabel!
    @IBOutlet weak var vwSenderUserMessage: UIView!
    
    
    //MARK: - view lifw cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
