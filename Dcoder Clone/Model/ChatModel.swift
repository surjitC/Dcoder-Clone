//
//  ChatModel.swift
//  Dcoder Clone
//
//  Created by Hemant Gore on 02/02/20.
//  Copyright © 2020 Dream Big. All rights reserved.
//

import Foundation

// MARK: - Chat
struct Chat: Codable {
    var userName: String?
    var userImageURL: String?
    var isSentByMe: Bool = true
    var text: String?

    enum CodingKeys: String, CodingKey {
        case userName = "user_name"
        case userImageURL = "user_image_url"
        case isSentByMe = "is_sent_by_me"
        case text
    }
}
