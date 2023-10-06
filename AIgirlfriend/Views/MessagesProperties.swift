//
//  MessagesProperties.swift
//  AIgirlfriend
//
//  Created by netset on 17/07/23.
//

import UIKit
import Speech
import InstantSearchVoiceOverlay

//MARK: - Protocol
protocol MessageDelegate{
    func popToBack()
    func popActionSheet()
    func sendMessage(_ text:String)
    func gotoAudio(_ textMsg:String)
}

class MessagesProperties: UIView{
    
    //MARK: IBOutlet's
    @IBOutlet weak var messagesTblVw: UITableView!
    @IBOutlet weak var emojiKeyboardTF: UITextField!
    @IBOutlet weak var imgVwTyping: UIImageView!
    @IBOutlet weak var messageTxtVw: UITextView!
    @IBOutlet weak var cnstBottomVwMessage: NSLayoutConstraint!
    @IBOutlet weak var cnstHeightVwTextMessage: NSLayoutConstraint!
    @IBOutlet weak var vwTextMessage: UIView!
    @IBOutlet weak var btnAudioInput: UIButton!
    @IBOutlet weak var constHeightImgVwTyping: NSLayoutConstraint!
    
    //MARK: Variable Declaration
    var objMessageDelegate:MessageDelegate?
    let voiceOverlayController = VoiceOverlayController()
    
    //MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: IBAction's
    @IBAction func btnActionBack(_ sender: Any) {
        objMessageDelegate?.popToBack()
    }
    
    @IBAction func actionBtnAudioInput(_ sender: Any) {
        actionBtnAudio()
    }
    
    
    @IBAction func btnActionSend(_ sender: Any) {
        if !messageTxtVw.text.isBlank {
            objMessageDelegate?.sendMessage(messageTxtVw.text ?? "")
        }
    }
    
    func actionBtnAudio() {
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            if authStatus == .authorized {
                self.configureSpeechToTextMethod()
            } else {
                Alerts.shared.alertMessageWithActionOkAndCancel(title: Appinfo.appName, message: "Pleaase enable speech-to-text permission in your device setting.") {
                    let url:URL = URL(string: UIApplication.openSettingsURLString)!
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    }
}

extension MessagesProperties: UITextViewDelegate {
    
    // MARK: Text View Delegate Method
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let _char = text.cString(using: String.Encoding.utf8)
        let isBackSpace: Int = Int(strcmp(_char, "\\b"))
        if isBackSpace == -92 {
            return true
        }
        if (textView.text?.count == 0 && text == " ") || (textView.text?.count == 0 && text == "\n") {
            return false
        }
        if (range.location == 0 && text == " ") {
            return false
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.contentSize.height >= 120 {
            cnstHeightVwTextMessage.constant = 120
        } else if textView.contentSize.height < 55 {
            cnstHeightVwTextMessage.constant = 55
        } else {
            cnstHeightVwTextMessage.constant = (textView.contentSize.height + 7)
        }
    }
}

extension MessagesProperties: VoiceOverlayDelegate {
    
    // MARK: Configure Speech To Text Method
    func configureSpeechToTextMethod() {
        DispatchQueue.main.async {
            let currentCont = AppInitializers.shared.getCurrentViewController()
            self.voiceOverlayController.start(on: currentCont, textHandler: { (text, finalBool, extraInfo) in
                debugPrint("text:- ",text)
                debugPrint("finalBool:- ",finalBool)
                if finalBool {
                    if !text.isBlank {
                        self.objMessageDelegate?.gotoAudio(text)
                    }
                }
            }, errorHandler: { (error) in
                debugPrint("Callback: Error \(String(describing: error))")
            }, resultScreenHandler: { (text) in
                debugPrint("Result Screen: \(text)")
            })
        }
    }
    
    // Second way to listen to recording through delegate
    func recording(text: String?, final: Bool?, error: Error?) {
        
    }
    
}
