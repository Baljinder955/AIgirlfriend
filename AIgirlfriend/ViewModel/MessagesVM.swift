//
//  MessagesVM.swift
//  AIgirlfriend
//
//  Created by netset on 17/07/23.
//

import Foundation
import UIKit
import AVFoundation

struct MessageModel {
    
    var textMessage = String()
    var isSender = Bool()
    var isContactUsText = Bool()
    var isPlayAudio = Bool()
    var isAudioBtnShow = Bool()
    var dateTime = String()
    var messageId = String()
    var audioFile = String()
    var isDownloading = Bool()
    
    
}

class MessagesVM: NSObject {
    
    // MARK: - Variable Declaration
    var characterId = String()
    var otherCharName = String()
    var arrMessages = [MessageModel]()
    var chatRoomId = String()
    var isNewMsg = Bool()
    var isVoiceAvailable = Bool()
    var isAutoPlayMessage = Bool()
    var audioPlayer: AVPlayer?
    var selectedIndex = Int()
    var audioTimer:Timer?
    
    //MARK: - API Implement
    func getChatHistoryApiMethod(_ vc: UIViewController,completion: @escaping () -> Void) {
        let apiUrl = "https://onlyfantasy-ai.ecomempire.in/api/v1/get-chat-history"
        let param = [
            "character":"\(characterId)",
            "Token":"\(DataManager.accessToken)"
        ]
        WebServices.postRequest(url: apiUrl, VwController: vc, view: vc.view, param: param, method: .post, shouldAnimateHudd: true) { (responseObject) in
            let apiData = JSONDecoder().decode(model: MessageHistoryModel.self, data: responseObject)
            let messageArr = apiData?.history ?? []
            self.isVoiceAvailable = (apiData?.voice ?? false)
            for i in 0..<messageArr.count {
                let detail = messageArr[i]
                if (detail.chat?[0] ?? "") != "" {
                    // Sender
                    let dateTime = getTimeFormatInStr(getTime: detail.datetime ?? "", backendFormat: "yyyy-MM-dd HH:mm:ss", needTimeFormat: "hh:mm a")
                    let senderRequest = MessageModel(textMessage: detail.chat?[0] ?? "",isSender: true,dateTime: dateTime,messageId: detail._id ?? "",audioFile: detail.audio_url ?? "")
                    self.arrMessages.append(senderRequest)
                    // Receiver
                    let receiverRequest = MessageModel(textMessage: detail.chat?[1] ?? "",isSender: false,dateTime: dateTime,messageId: detail._id ?? "",audioFile: detail.audio_url ?? "")
                    self.arrMessages.append(receiverRequest)
                } else {
                    // Receiver
                    let dateTime = getTimeFormatInStr(getTime: detail.datetime ?? "", backendFormat: "yyyy-MM-dd HH:mm:ss", needTimeFormat: "hh:mm a")
                    let receiverRequest = MessageModel(textMessage: detail.chat?[1] ?? "",isSender: false,dateTime: dateTime,messageId: detail._id ?? "",audioFile: detail.audio_url ?? "")
                    self.arrMessages.append(receiverRequest)
                }
            }
            self.chatRoomId = apiData?.room ?? ""
            completion()
        }
    }
    
    
    
    func getAudioUrlApiMethod(_ messageId:String,vc: UIViewController,completion: @escaping () -> Void) {
        let apiUrl = "https://onlyfantasy-ai.ecomempire.in/api/v1/message-tts"
        let param = [
            "message_id":messageId
        ]
        WebServices.postRequest(url: apiUrl, VwController: vc, view: vc.view, param: param, method: .post, shouldAnimateHudd: false) { (responseObject) in
            completion()
        }
    }
    
    func checkAudioStatusUrlApiMethod(_ messageId:String,vc: UIViewController,completion: @escaping (String) -> Void) {
        let apiUrl = "https://onlyfantasy-ai.ecomempire.in/api/v1/get-tts-status"
        let param = [
            "message_id":messageId
        ]
        WebServices.postRequest(url: apiUrl, VwController: vc, view: vc.view, param: param, method: .post, shouldAnimateHudd: false) { (responseObject) in
            let apiData = JSONDecoder().decode(model: AudioStatusModel.self, data: responseObject)
            completion(apiData?.audio_url ?? "")
        }
    }
    
}
