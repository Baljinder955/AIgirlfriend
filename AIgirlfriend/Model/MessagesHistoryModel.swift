//
//  MessagesHistoryModel.swift
//  AIgirlfriend
//
//  Created by netset on 30/08/23.
//

import Foundation

struct MessageHistoryModel : Codable {
    let room : String?
    let history : [History]?
    let voice : Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case room = "room"
        case history = "history"
        case voice = "voice"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        room = try values.decodeIfPresent(String.self, forKey: .room)
        history = try values.decodeIfPresent([History].self, forKey: .history)
        voice = try values.decodeIfPresent(Bool.self, forKey: .voice)
    }
}

struct History : Codable {
    let chat : [String]?
    let datetime : String?
    let _id : String?
    let audio_url : String?
    
    enum CodingKeys: String, CodingKey {
        
        case chat = "chat"
        case datetime = "datetime"
        case _id = "_id"
        case audio_url = "audio_url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        chat = try values.decodeIfPresent([String].self, forKey: .chat)
        datetime = try values.decodeIfPresent(String.self, forKey: .datetime)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        audio_url = try values.decodeIfPresent(String.self, forKey: .audio_url)
    }
    
}
struct AudioStatusModel : Codable {
    let audio_url : String?
    
    enum CodingKeys: String, CodingKey {
        
        case audio_url = "audio_url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        audio_url = try values.decodeIfPresent(String.self, forKey: .audio_url)
    }
}
