//
//  ModelLoginVC.swift
//  AIgirlfriend
//
//  Created by netset on 25/08/23.
//

import Foundation

struct loginBase : Codable {
    let _id : String?
    let firstName : String?
    let lastName : String?
    let email : String?
    let registration_type : String?
    let forgot_token : String?
    let is_creator : Bool?
    let username : String?
    let social_id : String?
    let email_verified : String?
    let is_verified : Bool?
    let first_login : Bool?
    let interest : [String]?
    let enable_imageBot : Bool?
    let enable_chatBot : Bool?
    let admin_status : String?
    let isFeature : Bool?
    let termCondition : Bool?
    let kYC_verified : String?
    let message_autoplay : Bool?
    let createdAt : String?
    let updatedAt : String?
    let __v : Int?
    let auth_token : String?
    
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case firstName = "firstName"
        case lastName = "lastName"
        case email = "email"
        case registration_type = "registration_type"
        case forgot_token = "forgot_token"
        case is_creator = "is_creator"
        case username = "username"
        case social_id = "social_id"
        case email_verified = "email_verified"
        case is_verified = "is_verified"
        case first_login = "first_login"
        case interest = "interest"
        case enable_imageBot = "enable_imageBot"
        case enable_chatBot = "enable_chatBot"
        case admin_status = "admin_status"
        case isFeature = "isFeature"
        case termCondition = "termCondition"
        case kYC_verified = "KYC_verified"
        case message_autoplay = "message_autoplay"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case __v = "__v"
        case auth_token = "auth_token"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        registration_type = try values.decodeIfPresent(String.self, forKey: .registration_type)
        forgot_token = try values.decodeIfPresent(String.self, forKey: .forgot_token)
        is_creator = try values.decodeIfPresent(Bool.self, forKey: .is_creator)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        social_id = try values.decodeIfPresent(String.self, forKey: .social_id)
        email_verified = try values.decodeIfPresent(String.self, forKey: .email_verified)
        is_verified = try values.decodeIfPresent(Bool.self, forKey: .is_verified)
        first_login = try values.decodeIfPresent(Bool.self, forKey: .first_login)
        interest = try values.decodeIfPresent([String].self, forKey: .interest)
        enable_imageBot = try values.decodeIfPresent(Bool.self, forKey: .enable_imageBot)
        enable_chatBot = try values.decodeIfPresent(Bool.self, forKey: .enable_chatBot)
        admin_status = try values.decodeIfPresent(String.self, forKey: .admin_status)
        isFeature = try values.decodeIfPresent(Bool.self, forKey: .isFeature)
        termCondition = try values.decodeIfPresent(Bool.self, forKey: .termCondition)
        kYC_verified = try values.decodeIfPresent(String.self, forKey: .kYC_verified)
        message_autoplay = try values.decodeIfPresent(Bool.self, forKey: .message_autoplay)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        __v = try values.decodeIfPresent(Int.self, forKey: .__v)
        auth_token = try values.decodeIfPresent(String.self, forKey: .auth_token)
    }
}


struct LoginDataModel : Codable {
    let status : String?
    let responseCode : Int?
    let data : SavedData?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case responseCode = "responseCode"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        responseCode = try values.decodeIfPresent(Int.self, forKey: .responseCode)
        data = try values.decodeIfPresent(SavedData.self, forKey: .data)
    }
    
}

struct SavedData : Codable {
    let saveData : loginBase?
    let token : String?
    let update : Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case saveData = "saveData"
        case token = "token"
        case update = "update"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        saveData = try values.decodeIfPresent(loginBase.self, forKey: .saveData)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        update = try values.decodeIfPresent(Bool.self, forKey: .update)
    }
}
