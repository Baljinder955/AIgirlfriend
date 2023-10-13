//
//  MessagesVCExt.swift
//  AIgirlfriend
//
//  Created by netset on 17/07/23.
//

import Foundation
import UIKit
import ISEmojiView
import AVFoundation

extension MessagesVC:EmojiViewDelegate {
    
    
    // MARK: - EmojiPicker
    func emojiViewDidSelectEmoji(_ emoji: String, emojiView: EmojiView) {
        vwProperties.messageTxtVw.insertText(emoji)
    }
    
    func emojiViewDidPressChangeKeyboardButton(_ emojiView: EmojiView) {
        vwProperties.messageTxtVw.inputView = nil
        vwProperties.messageTxtVw.keyboardType = .asciiCapable
        vwProperties.messageTxtVw.reloadInputViews()
    }
    
    func emojiViewDidPressDeleteBackwardButton(_ emojiView: EmojiView) {
        vwProperties.messageTxtVw.deleteBackward()
    }
    
    func emojiViewDidPressDismissKeyboardButton(_ emojiView: EmojiView) {
        vwProperties.messageTxtVw.resignFirstResponder()
    }
    
}

extension MessagesVC: UITextFieldDelegate {
    
    //MARK: - Text Field Delegates
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == vwProperties.emojiKeyboardTF {
            vwProperties.emojiKeyboardTF.alpha = 0.0
            let updatedText = vwProperties.emojiKeyboardTF.text!.last!
            vwProperties.messageTxtVw.text! += "\(updatedText)"
        }
    }
}

extension MessagesVC : MessageDelegate {
    
    //MARK: - CustomFunction
    func popToBack() {
        self.popViewController(true)
    }
    
    func popActionSheet() {
    }
    
    // MARK: - Send Message Function
    func sendMessage(_ text: String) {
        self.vwProperties.messageTxtVw.resignFirstResponder()
        objMessagesVM.isNewMsg = true
        showTypingGifMethod(isHide: false)
        let requestEmpty = MessageModel(textMessage: text,isSender: true, dateTime: getStringFromDate(date: Date(), needFormat: "hh:mm a"))
        self.objMessagesVM.arrMessages.append(requestEmpty)
        self.vwProperties.messagesTblVw.reloadData()
            let param = [
                "character":"\(self.objMessagesVM.fileName)",
                "token":"\(DataManager.accessToken)",
                "user_input":"\(text)",
                "your_name":"\(DataManager.userFirstName)"
            ]
            scrollToBottomTblVw(false)
            self.wsForChat.sendMessgaeApiMethod(param)
            self.vwProperties.messageTxtVw.text = ""
            self.vwProperties.messageTxtVw.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.0001) {
                let indexPath = IndexPath(row: self.objMessagesVM.arrMessages.count - 1, section: 0)
                self.vwProperties.messagesTblVw.reloadRows(at: [indexPath], with: .none)
                self.vwProperties.messagesTblVw.scrollToRow(at: indexPath, at: .bottom, animated: false)
            }
    }
    
    // MARK: Audio Recording Button Clicled
    func gotoAudio(_ textMsg:String) {
        vwProperties.messageTxtVw.text = textMsg
        self.vwProperties.textViewDidChange(self.vwProperties.messageTxtVw)
        if !wsForChat.checkConnectivity() {
            DispatchQueue.main.async {
                self.wsForChat = WebSocketFile(path: "chat-stream")
                self.wsForAudio = WebSocketFile(path: "audio_stream")
                self.wsForChat.delegateChat = self
            }
        }
    }
    
    func showTypingGifMethod(isHide:Bool) {
        vwProperties.imgVwTyping.isHidden = isHide
        let imageGif =  UIImage.gif(name: "LiveSupportIsTyping")
        DispatchQueue.main.async {
            self.vwProperties.imgVwTyping.image = imageGif
        }
    }
}

extension MessagesVC {
    
    func audioPlayMethod(_ indexSelected: Int) {
        let detail = objMessagesVM.arrMessages[indexSelected]
        if detail.audioFile != "" {
            if objMessagesVM.selectedIndex == indexSelected {
                if objMessagesVM.arrMessages[indexSelected].isPlayAudio {
                    objMessagesVM.arrMessages[indexSelected].isPlayAudio = false
                    objMessagesVM.audioPlayer?.pause()
                } else {
                    objMessagesVM.arrMessages[indexSelected].isPlayAudio = true
                    objMessagesVM.audioPlayer?.play()
                }
                self.vwProperties.messagesTblVw.reloadRows(at: [IndexPath(row: indexSelected, section: 0)], with: .fade)
            } else {
                if objMessagesVM.arrMessages[indexSelected].isPlayAudio {
                    objMessagesVM.arrMessages[indexSelected].isPlayAudio = false
                    objMessagesVM.audioPlayer?.pause()
                    self.vwProperties.messagesTblVw.reloadRows(at: [IndexPath(row: indexSelected, section: 0)], with: .fade)
                } else {
                    if let index = objMessagesVM.arrMessages.firstIndex(where: { ($0.isPlayAudio) }) {
                        objMessagesVM.arrMessages[index].isPlayAudio = false
                        objMessagesVM.audioPlayer?.pause()
                    }
                    DispatchQueue.main.async {
                        let data = self.objMessagesVM.arrMessages[indexSelected]
                        if data.audioFile != "" {
                            let urlStr = data.audioFile
                            if let audioURL = URL(string: urlStr) {
                                let playerItem = AVPlayerItem(url: audioURL)
                                self.objMessagesVM.audioPlayer = AVPlayer(playerItem:playerItem)
                                self.objMessagesVM.audioPlayer!.volume = 1.0
                                self.objMessagesVM.audioPlayer!.play()
                                self.objMessagesVM.arrMessages[indexSelected].isDownloading = false
                                self.objMessagesVM.arrMessages[indexSelected].isPlayAudio = true
                                self.objMessagesVM.selectedIndex = indexSelected
                                self.vwProperties.messagesTblVw.reloadRows(at: [IndexPath(row: indexSelected, section: 0)], with: .fade)
                                NotificationCenter.default.addObserver(self, selector: #selector(self.finishedPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
                            }
                        }
                    }
                }
            }
        } else {
            debugPrint("MessageId : ",detail.messageId)
            debugPrint("Selected Index : ",indexSelected)
            self.getMessageIndex = indexSelected
            objMessagesVM.arrMessages[self.getMessageIndex].isDownloading = true
            vwProperties.messagesTblVw.reloadRows(at: [IndexPath(row: self.getMessageIndex, section: 0)], with: .fade)
            downloadAudioUrlMethod(detail.messageId)
        }
    }
    
    func downloadAudioUrlMethod(_ messageID: String) {
//        self.wsForAudio = WebSocketFile(path: "message-tts-stream/\(messageID)")
//        self.wsForAudio.delegateChat = self
//        let param = [
//            "token":"\(DataManager.accessToken)"
//        ]
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            self.wsForAudio.sendMessgaeApiMethod(param)
//        }
        objMessagesVM.getAudioUrlApiMethod(messageID, vc: self) {
            self.objMessagesVM.audioTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.checkAudioStatusMethod), userInfo: nil, repeats: true)
        }
        
        
    }
    
    @objc func finishedPlaying( _ myNotification:NSNotification) {
        objMessagesVM.audioPlayer?.pause()
        objMessagesVM.audioPlayer!.seek(to: .zero)
        self.objMessagesVM.arrMessages[self.objMessagesVM.selectedIndex].isPlayAudio = false
        self.objMessagesVM.arrMessages[self.objMessagesVM.selectedIndex].isDownloading = false
        vwProperties.messagesTblVw.reloadRows(at: [IndexPath(row: self.objMessagesVM.selectedIndex, section: 0)], with: .fade)
    }
    
    func scrollToBottomTblVw(_ isAnimated:Bool){
        if self.objMessagesVM.arrMessages.count > 0 {
            let indexPath = IndexPath(row: (self.objMessagesVM.arrMessages.count - 1), section: 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.vwProperties.messagesTblVw.scrollToRow(at: indexPath, at: .bottom, animated: isAnimated)
            }
        }
    }
    
    @objc func checkAudioStatusMethod() {
        objMessagesVM.checkAudioStatusUrlApiMethod(objMessagesVM.arrMessages[self.getMessageIndex].messageId, vc: self) { (audioUrlStr) in
            if audioUrlStr != "" {
                self.objMessagesVM.audioTimer?.invalidate()
                self.objMessagesVM.audioTimer = nil
                if self.getMessageIndex <= (self.objMessagesVM.arrMessages.count - 1) {
                    debugPrint("Download Index - ",self.getMessageIndex)
                    debugPrint("Download Id - ",self.objMessagesVM.arrMessages[self.getMessageIndex].messageId)
                    self.objMessagesVM.arrMessages[self.getMessageIndex].audioFile = audioUrlStr
                    self.audioPlayMethod(self.getMessageIndex)
                }
            } 
            
        }
        
    }
    
}
