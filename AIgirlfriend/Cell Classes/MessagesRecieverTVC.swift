//
//  MessagesRecieverTVC.swift
//  AIgirlfriend
//
//  Created by netset on 17/07/23.
//

import UIKit

class MessagesRecieverTVC: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var vwUserChat: UIView!
    @IBOutlet weak var lblUserMessage: UILabel!
    @IBOutlet weak var lblMessageReceivedTiming: UILabel!
    @IBOutlet weak var cnstLeadingImgVwPlayIcon: NSLayoutConstraint!
    @IBOutlet weak var cnstWidthImgVwPlayIcon: NSLayoutConstraint!
    @IBOutlet weak var imgVwPlayIcon: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - View life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
