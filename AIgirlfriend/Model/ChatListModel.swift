//
//  ChatListModel.swift
//  AIgirlfriend
//
//  Created by netset on 29/08/23.
//

import Foundation
struct ChatDataListModel : Codable {
    let status : String?
    let responseCode : Int?
    let message : Message?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case responseCode = "responseCode"
        case message = "message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        responseCode = try values.decodeIfPresent(Int.self, forKey: .responseCode)
        message = try values.decodeIfPresent(Message.self, forKey: .message)
    }
    
}

struct Message : Codable {
    let chatList : [ChatList]?
    var message_autoplay : Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case chatList = "chatList"
        case message_autoplay = "message_autoplay"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        chatList = try values.decodeIfPresent([ChatList].self, forKey: .chatList)
        message_autoplay = try values.decodeIfPresent(Bool.self, forKey: .message_autoplay)
    }
    
}

struct ChatList : Codable {
    let _id : String?
    let user : String?
    let internalArr : [String]?
    let visible : [String]?
    let created_at : String?
    let character : String?
    let room : String?
    let characterObj : CharacterModel?
    
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case user = "user"
        case internalArr = "internal"
        case visible = "visible"
        case created_at = "created_at"
        case character = "character"
        case room = "room"
        case characterObj = "_character"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        user = try values.decodeIfPresent(String.self, forKey: .user)
        internalArr = try values.decodeIfPresent([String].self, forKey: .internalArr)
        visible = try values.decodeIfPresent([String].self, forKey: .visible)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        character = try values.decodeIfPresent(String.self, forKey: .character)
        room = try values.decodeIfPresent(String.self, forKey: .room)
        characterObj = try values.decodeIfPresent(CharacterModel.self, forKey: .characterObj)
    }
    
}

struct CharacterModel : Codable {
    let _id : String?
    let user : String?
    let name : String?
    let greeting : String?
    let context : String?
    let description : String?
    let image : String?
    let tts_voice : String?
    let filename : String?
    let sd_sd_keywordword : String?
    let sd_model : String?
    
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case user = "user"
        case name = "name"
        case greeting = "greeting"
        case context = "context"
        case description = "description"
        case image = "image"
        case tts_voice = "tts_voice"
        case filename = "filename"
        case sd_sd_keywordword = "sd_keyword"
        case sd_model = "sd_model"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        user = try values.decodeIfPresent(String.self, forKey: .user)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        greeting = try values.decodeIfPresent(String.self, forKey: .greeting)
        context = try values.decodeIfPresent(String.self, forKey: .context)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        tts_voice = try values.decodeIfPresent(String.self, forKey: .tts_voice)
        filename = try values.decodeIfPresent(String.self, forKey: .filename)
        sd_sd_keywordword = try values.decodeIfPresent(String.self, forKey: .sd_sd_keywordword)
        sd_model = try values.decodeIfPresent(String.self, forKey: .sd_model)
    }
    
}





