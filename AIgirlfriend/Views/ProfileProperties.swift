//
//  ProfileProperties.swift
//  AIgirlfriend
//
//  Created by netset on 17/07/23.
//

import UIKit

//MARK: - Protocol
protocol ProfileDelegates {
    func popToBack()
    func gotoChat()
}

class ProfileProperties: UIView {
    
    //MARK: - IBOutlets
    @IBOutlet weak var lblProfileUserName: UILabel!
    @IBOutlet weak var imgVwuserProfile: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var lblUserBehaviour: UILabel!
    @IBOutlet weak var lblUserBio: UILabel!
    @IBOutlet weak var BtnChatNow: UIButton!
    @IBOutlet weak var vwChatNow: Gradient!
    @IBOutlet weak var cnstHeightVwDescript: NSLayoutConstraint!
    @IBOutlet weak var cnstVwChatNowTop: NSLayoutConstraint!
    @IBOutlet weak var vwUserBio: UIView!
    
    //MARK: Variable Declaration
    var objProfileDelegate:ProfileDelegates?
    
    // MARK: View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: IBAction's
    @IBAction func actionBtnBack(_ sender: Any) {
        objProfileDelegate?.popToBack()
    }
    
    @IBAction func actionBtnChatNow(_ sender: Any) {
        objProfileDelegate?.gotoChat()
    }
}

extension ProfileProperties {
    
    //MARK: - Custom Function's
    func prepareUIMethod(dataDetailed:MessageDataModel?) {
        if dataDetailed?.description == "" || dataDetailed?.description == nil{
            vwUserBio.isHidden = true
            cnstHeightVwDescript.constant = -20
            cnstVwChatNowTop.constant = 0
        } else {
            cnstVwChatNowTop.constant = 25
            vwUserBio.isHidden = false
            let formatStr = NSMutableAttributedString()
            formatStr.attributedString(dataDetailed?.description ?? "", color: .white, font: UIFont(name: "Montserrat", size: 14)!, lineHeight: 2.0, align: TextAlign.center)
            lblUserBio.attributedText = formatStr
            cnstHeightVwDescript.constant = lblUserBio.intrinsicContentSize.height + 40
        }
    }
    
    func showUserDetailMethod(_ detailDict:HomeBaseModel?) {
        if detailDict != nil {
            lblProfileUserName.text = detailDict?.name ?? ""
            lblUserName.text = detailDict?.name ?? ""
            let imgUrl = URL(string: "https://onlyfantasy-ai.ecomempire.in/media/characters/\(detailDict?.image ?? "")")
            imgVwuserProfile.sd_setImage(with: imgUrl)
            self.lblUserEmail.text = "@\(detailDict?.name ?? "")"
        } else {
            let userData = UserDefaults.standard.value(forKey: "userData") as? [String:Any]
            let name = userData?["firstName"] as? String ?? "empty name"
            let email = userData?["email"] as? String ?? "empty email"
            lblProfileUserName.text = name
            lblUserName.text = name
            lblUserEmail.text = email
            lblUserBio.text = description
        }
    }
}

