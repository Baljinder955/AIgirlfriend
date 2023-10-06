//
//  ProfileVCModel.swift
//  AIgirlfriend
//
//  Created by netset on 07/09/23.
//

import Foundation

struct ProfileModel : Codable {
    let status : String?
    let responseCode : Int?
    let message : MessageDataModel?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case responseCode = "responseCode"
        case message = "message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        responseCode = try values.decodeIfPresent(Int.self, forKey: .responseCode)
        message = try values.decodeIfPresent(MessageDataModel.self, forKey: .message)
    }
}

struct MessageDataModel : Codable {
    let _id : String?
    let user : String?
    let name : String?
    let greeting : String?
    let context : String?
    let description : String?
    let image : String?
    let tts_voice : String?
    let filename : String?
    let gender : String?
    let repetations : String?
    let sd_keyword : String?
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
        case gender = "gender"
        case repetations = "repetations"
        case sd_keyword = "sd_keyword"
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
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        repetations = try values.decodeIfPresent(String.self, forKey: .repetations)
        sd_keyword = try values.decodeIfPresent(String.self, forKey: .sd_keyword)
        sd_model = try values.decodeIfPresent(String.self, forKey: .sd_model)
    }
}
