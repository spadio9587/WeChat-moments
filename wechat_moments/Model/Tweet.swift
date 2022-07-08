//
//  Tweet.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/4/19.
//

import Foundation

public struct Tweet: Codable {
    let content: String?
    let images: [Image]?
    let sender: Sender?
    let comments: [Comment]?
}

public struct Image: Codable {
    let url: String
}

public struct Sender: Codable {
    let username: String
    let nick: String
    let avatar: String
}

public struct Comment: Codable {
    let content: String
    let sender: Sender
}

public struct UserInfo: Codable {
    let profileImage: String
    let avatar: String
    let nick: String
    let userName: String

    private enum CodingKeys: String, CodingKey {
        case profileImage = "profile-image"
        case avatar
        case nick
        case userName = "username"
    }
}
