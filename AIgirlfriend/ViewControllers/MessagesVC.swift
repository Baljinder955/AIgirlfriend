//
//  MessagesVC.swift
//  AIgirlfriend
//
//  Created by netset on 17/07/23.
//

import UIKit
import IQKeyboardManagerSwift
import ISEmojiView

class MessagesVC: UIViewController, UITextViewDelegate {
    
    //MARK: - IBOutlet's
    @IBOutlet var vwProperties: MessagesProperties!
    
    //MARK: Variable Declaration
    var objMessagesVM = MessagesVM()
    var textFieldData = [""]
    private var delegate: MessgeDelegates!
    private var dataSource: MessagesDataSource!
    var wsForChat: WebSocketFile!
    var wsForAudio: WebSocketFile!
    var previewImage = UIImage()
    var timer:Timer?
    var getMessageIndex = Int()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUIMethod()
        view.isUserInteractionEnabled = true
        self.vwProperties.objMessageDelegate = self
        self.vwProperties.messagesTblVw.estimatedRowHeight = 100
        self.vwProperties.messagesTblVw.rowHeight = UITableView.automaticDimension
        initializeViewDataSource()
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
        startKeyboardObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.objMessagesVM.audioTimer?.invalidate()
        self.objMessagesVM.audioTimer = nil
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        self.stopKeyboardObserver()
        NotificationCenter.default.removeObserver(self, name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        objMessagesVM.audioPlayer?.pause()
        objMessagesVM.audioPlayer = nil
        if wsForChat != nil {
            wsForChat.disconnect()
        }
        if wsForAudio != nil {
            wsForAudio.disconnect()
        }
    }
    
    //MARK: - DataSource + Delegates
    func initializeViewDataSource(){
        dataSource = MessagesDataSource(viewModel: objMessagesVM)
        delegate = MessgeDelegates(viewModel: objMessagesVM)
        vwProperties.messagesTblVw.dataSource = dataSource
        vwProperties.messagesTblVw.delegate = delegate
        vwProperties.emojiKeyboardTF.delegate = self
        emojiKeyboard()
        objMessagesVM.getChatHistoryApiMethod(self) {
            self.vwProperties.messagesTblVw.reloadData()
            self.congigureSocketMethod()
            self.reloadTableData()
        }
        delegate.callBackDidSeclect = { (selectIndex) in
            self.audioPlayMethod(selectIndex)
        }
    }
    
    //MARK: - Socket Configure
    private func congigureSocketMethod() {
        DispatchQueue.main.async {
            self.wsForChat = WebSocketFile(path: "chat-stream/\(self.objMessagesVM.chatRoomId)")
            self.wsForChat.delegateChat = self
        }
    }
    
    //MARK: - Custom Function's
    private func prepareUIMethod(){
        vwProperties.objMessageDelegate = self
    }
    
    func reloadTableData() {
        if self.objMessagesVM.arrMessages.count > 0 {
            let indexPath = IndexPath(row: self.objMessagesVM.arrMessages.count - 1, section: 0)
            self.vwProperties.messagesTblVw.reloadRows(at: [indexPath], with: .none)
            self.vwProperties.messagesTblVw.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
    
    //MARK: - Emoji Keyboard
    func emojiKeyboard() {
        let keyboardSettings = KeyboardSettings(bottomType: .categories.self)
        keyboardSettings.needToShowAbcButton = false
        keyboardSettings.updateRecentEmojiImmediately = true
        keyboardSettings.needToShowDeleteButton = true
        keyboardSettings.countOfRecentsEmojis = Int(20)
        let emojiView = EmojiView(keyboardSettings: keyboardSettings)
        emojiView.translatesAutoresizingMaskIntoConstraints = false
        emojiView.delegate = self
        vwProperties.emojiKeyboardTF.inputView = emojiView
        vwProperties.messageTxtVw.reloadInputViews()
        vwProperties.messageTxtVw.textColor = .white
        vwProperties.messageTxtVw.font = UIFont(name: "Montserrat", size: 14)
    }
    
    fileprivate func startKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    fileprivate func stopKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let userInfo = (notification as NSNotification).userInfo {
            let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
            self.vwProperties.cnstBottomVwMessage.constant = (frame.height - self.view.safeAreaInsets.bottom) + 10
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        vwProperties.cnstBottomVwMessage.constant = 10
    }
    
    @objc func didEnterBackground() {
        debugPrint("DidEnterBackground")
        let backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
        //        self.objMessagesVM.synth.stopSpeaking(at: .immediate)
        UIApplication.shared.endBackgroundTask(backgroundTaskIdentifier)
    }
    
    @objc func appWillEnterForeground() {
        debugPrint("appWillEnterForeground")
        if let index = self.objMessagesVM.arrMessages.firstIndex(where: { ($0.isPlayAudio) }) {
            self.objMessagesVM.arrMessages[index].isPlayAudio = false
        }
        self.vwProperties.messagesTblVw.reloadData()
    }
}

// MARK: -  Socket implement
extension MessagesVC: WebSocketEndpointDelegate {
    
    func socketConnected() {
    }
    
    func chatCallbackMethod(_ dict: SocketModel) {
        DispatchQueue.main.async {
            self.vwProperties.imgVwTyping.isHidden = true
            self.scrollToBottomTblVw(false)
            if dict.streamEvent == "text_stream" || dict.streamEvent == "stream_end" {
                if self.objMessagesVM.isNewMsg {
                    let requestEmpty = MessageModel(textMessage: dict.message,isSender: false, dateTime: getStringFromDate(date: Date(), needFormat: "hh:mm a"),messageId: dict.message_id)
                    self.objMessagesVM.arrMessages.append(requestEmpty)
                    self.objMessagesVM.isNewMsg = false
                    UIView.animate(withDuration: 0.0001) {
                        self.vwProperties.messagesTblVw.reloadData()
                        let indexPath = IndexPath(row: self.objMessagesVM.arrMessages.count - 1, section: 0)
                        self.vwProperties.messagesTblVw.scrollToRow(at: indexPath, at: .bottom, animated: false)
                    }
                } else {
                    if dict.streamEvent == "stream_end" {
                        self.objMessagesVM.arrMessages[self.objMessagesVM.arrMessages.count - 1].messageId = dict.message_id
                        if self.objMessagesVM.isAutoPlayMessage && self.objMessagesVM.isVoiceAvailable {
                            self.audioPlayMethod(self.objMessagesVM.arrMessages.count - 1)
                        }
                        self.vwProperties.messageTxtVw.isUserInteractionEnabled = true
                        self.objMessagesVM.isNewMsg = true
                    } else {
                        self.objMessagesVM.arrMessages[self.objMessagesVM.arrMessages.count - 1].textMessage = dict.message
                    }
                    UIView.animate(withDuration: 0.0001) {
                        let indexPath = IndexPath(row: self.objMessagesVM.arrMessages.count - 1, section: 0)
                        self.vwProperties.messagesTblVw.reloadRows(at: [indexPath], with: .none)
                        self.vwProperties.messagesTblVw.scrollToRow(at: indexPath, at: .bottom, animated: false)
                    }
                }
            } else if dict.streamEvent == "audio_stream" || dict.streamEvent == "audio_stream_end" {
                if dict.status == 1 && dict.audioUrl != "" {
                    if self.getMessageIndex <= (self.objMessagesVM.arrMessages.count - 1) {
                        debugPrint("Download Index - ",self.getMessageIndex)
                        debugPrint("Download Id - ",self.objMessagesVM.arrMessages[self.getMessageIndex].messageId)
                        self.objMessagesVM.arrMessages[self.getMessageIndex].audioFile = dict.audioUrl
                        self.audioPlayMethod(self.getMessageIndex)
                    }
                }
            } else {
                self.vwProperties.messageTxtVw.isUserInteractionEnabled = true
                self.objMessagesVM.isNewMsg = true
                self.vwProperties.imgVwTyping.isHidden = true
            }
        }
    }
    
    func chatErrorMessage(_ dict: SocketModel){
        self.vwProperties.imgVwTyping.isHidden = true
    }
    
    func socketDisconnectedError() {
        self.vwProperties.imgVwTyping.isHidden = true
    }
}
