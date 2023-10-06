//
//  ModelHomeVC.swift
//  AIgirlfriend
//
//  Created by netset on 29/08/23.
//

import Foundation

struct HomeBaseModel : Codable {
    let id : String?
    let name : String?
    let image : String?
    let image_bot : Bool?
    let chat_bot : Bool?
    let voice : Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case image = "image"
        case image_bot = "image_bot"
        case chat_bot = "chat_bot"
        case voice = "voice"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        image_bot = try values.decodeIfPresent(Bool.self, forKey: .image_bot)
        chat_bot = try values.decodeIfPresent(Bool.self, forKey: .chat_bot)
        voice = try values.decodeIfPresent(Bool.self, forKey: .voice)
    }
    
}
