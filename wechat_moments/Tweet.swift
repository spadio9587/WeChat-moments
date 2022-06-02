//
//  Tweet.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/4/19.
//

import Foundation

struct Tweet: Codable {
    let content: String?
    let images: [Image]?
    let sender: Sender?
    let comments: [Comment]?
}

struct Image: Codable {
    let url: String
}

struct Sender: Codable {
    let username: String
    let nick: String
    let avatar: String
}

struct Comment: Codable {
    let content: String
    let sender: Sender
}

struct UserInfo: Codable {
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
