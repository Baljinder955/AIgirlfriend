//
//  ChatTVC.swift
//  AIgirlfriend
//
//  Created by netset on 12/07/23.
//

import UIKit

class ChatTVC: UITableViewCell, Reusable {

    //MARK: - IBOutlet's
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblMsg: UILabel!
    
    //MARK: - View lifw cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
