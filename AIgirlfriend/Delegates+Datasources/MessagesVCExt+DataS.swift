//
//  MessagesVCExt+DataS.swift
//  AIgirlfriend//
//  Created by netset on 17/07/23.
//

import UIKit

//MARK: - TableView DataSources
class MessagesDataSource: NSObject,UITableViewDataSource {
    
    //MARK: - Variable Declared
    private let viewModel:MessagesVM!
    
    init(viewModel: MessagesVM!) {self.viewModel = viewModel}
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrMessages.count
    }
    
    // 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel.arrMessages[indexPath.row]
        if data.isSender {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessagesSenderTVC", for: indexPath) as! MessagesSenderTVC
            cell.lblSenderUserName.text = "You"
            cell.lblSenderUserMessage.text = data.textMessage
            cell.lblUserMessageSendTime.text = data.dateTime
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessagesRecieverTVC", for: indexPath) as! MessagesRecieverTVC
            cell.lblUserName.text = viewModel.otherCharName
            cell.lblUserMessage.text = data.textMessage
            cell.lblMessageReceivedTiming.text = data.dateTime
            if viewModel.isVoiceAvailable {
                cell.imgVwPlayIcon.isHidden = false
                cell.cnstLeadingImgVwPlayIcon.constant = 10
                cell.cnstWidthImgVwPlayIcon.constant = 18
                if data.isPlayAudio {
                    cell.imgVwPlayIcon.image = UIImage(named: "pause.fill")
                    cell.activityIndicator.isHidden = true
                    cell.activityIndicator.stopAnimating()
                } else {
                    if data.isDownloading {
                        cell.activityIndicator.isHidden = false
                        cell.imgVwPlayIcon.image = UIImage(named: "")
                        cell.activityIndicator.startAnimating()
                    } else {
                        cell.imgVwPlayIcon.image = UIImage(named: "play.fill")
                        cell.activityIndicator.isHidden = true
                        cell.activityIndicator.stopAnimating()
                    }
                }
            } else {
                cell.imgVwPlayIcon.isHidden = true
                cell.activityIndicator.isHidden = true
                cell.cnstLeadingImgVwPlayIcon.constant = 5
                cell.cnstWidthImgVwPlayIcon.constant = 0
            }
            return cell
        }
    }
}

//MARK: - TableView Delegates
class MessgeDelegates:NSObject,UITableViewDelegate {
    
    private let viewModel:MessagesVM!
    var callBackDidSeclect:((Int)->())?
    
    init(viewModel: MessagesVM!) {self.viewModel = viewModel}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.arrMessages[indexPath.row]
        if !data.isSender && !data.isDownloading {
            self.callBackDidSeclect?(indexPath.row)
        }
    }
    
}

