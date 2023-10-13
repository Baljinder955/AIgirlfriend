//
//  WebSocketFile.swift
//  AIattorney
//
//  Created by netset on 12/07/23.
//

import SocketRocket

protocol WebSocketEndpointDelegate {
    func socketConnected()
    func chatCallbackMethod(_ dict:SocketModel)
    func chatErrorMessage(_ dict:SocketModel)
    func socketDisconnectedError()
}

final class WebSocketFile: NSObject {
    
    private var socket: SRWebSocket
    
    var delegateChat: WebSocketEndpointDelegate?
    
    var socketURL = "wss://onlyfantasy-ai.ecomempire.in/api/v1/"
    var socketURLNew = "wss://onlyfantasy-ws.ecomempire.in/api/v1/"
    
    
    init(path: String) {
        let socketPath = "\(socketURLNew)\(path)"
        let url = URL(string: socketPath)!
        debugPrint("Socket connect url :- ",socketPath)
        let request = URLRequest(url: url)
        self.socket = SRWebSocket(urlRequest: request)
        super.init()
        self.socket.delegate = self
        self.socket.open()
    }
    
    // MARK: Disconnect Method
    func disconnect() {
        self.socket.close()
    }
    
    // MARK: Send Messgae Api Method
    func sendMessgaeApiMethod(_ param:[String:Any]) {
        debugPrint("Param:- ",param)
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: param)
            if let json = String(data: jsonData, encoding: .utf8) {
                try self.socket.send(string: json)
            }
        } catch {
            debugPrint("Something went wrong with parsing json")
        }
    }
    
    // MARK: Check Connectivity
    func checkConnectivity() -> Bool {
        if self.socket.readyState == .OPEN {
            return true
        } else {
            return false
        }
    }
}

extension WebSocketFile: SRWebSocketDelegate {
    
    func webSocketDidOpen(_ webSocket: SRWebSocket) {
        debugPrint("WS: Did Open")
        self.delegateChat?.socketConnected()
    }
    
    func webSocket(_ webSocket: SRWebSocket, didFailWithError error: Error) {
        debugPrint("WS: Did fail with error: \(error.localizedDescription)")
    }
    
    func webSocket(_ webSocket: SRWebSocket, didCloseWithCode code: Int, reason: String?, wasClean: Bool) {
        debugPrint("WS: Did close with code: \(code)")
        self.delegateChat?.socketDisconnectedError()
    }
    
    func webSocket(_ webSocket: SRWebSocket, didReceiveMessage message: Any) {
        debugPrint("WS: Received:- ",message)        
        getValueInDictionary(message as? String ?? "") { (dict) in
            debugPrint("JSON Socket :- ",dict)
            var objSocketModel = SocketModel()
            objSocketModel.setDetail(dict)
            self.delegateChat?.chatCallbackMethod(objSocketModel)
        }
    }
    
    func webSocket(_ webSocket: SRWebSocket, didReceivePong pongPayload: Data?) {
        debugPrint("WS: Did receive pong payload: \(pongPayload.debugDescription)")
    }
}

func getValueInDictionary(_ messageStr: String,completion:@escaping(_ dict: NSDictionary) -> Void) {
    let text = messageStr
    guard let data = text.data(using: .utf8) else {
        return
    }
    guard let dictionary = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] else {
        return
    }
    completion(dictionary as NSDictionary)
}

struct SocketModel {
    
    var message = String()
    var message_num = Int()
    var streamEvent = String()
    var message_id = String()
    var audioUrl = String()
    var status = Int()
    
    mutating func setDetail(_ detail: NSDictionary) {
        message = detail["message"] as? String ?? ""
        message_num = getIntegerValue(detail["message_num"] as Any)
        streamEvent = detail["event"] as? String ?? ""
        message_id = detail["message_id"] as? String ?? ""
        audioUrl = detail["audio_url"] as? String ?? ""
        status = getIntegerValue(detail["status"] as Any)
        if message_id == "" {
            message_id = detail["msg_id"] as? String ?? ""
        }
    }
}

// MARK: Get Integer Value
func getIntegerValue(_ value:Any) -> Int {
    var integerValue = Int()
    if let getVal = value as? String {
        if getVal.isNumeric && getVal != "" {
            integerValue = Int(getVal) ?? 0
        }
    } else if let getVal = value as? Int {
        integerValue = getVal
    } else if let getVal = value as? Double {
        integerValue = Int(getVal)
    } else if let getVal = value as? Bool {
        integerValue = getVal ? 1 : 0
    }
    return integerValue
}

// MARK: Get String Value
func getStringValue(_ value:Any) -> String {
    var strValue = String()
    if let getVal = value as? String {
        strValue = getVal
    } else if let getVal = value as? Int {
        strValue = String(getVal)
    } else if let getVal = value as? Double {
        strValue = String(getVal)
    }
    return strValue
}

extension String {
    
    var isNumeric : Bool {
        return NumberFormatter().number(from: self) != nil
    }
    
}
