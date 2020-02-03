//
//  CodeModel.swift
//  Dcoder Clone
//
//  Created by Hemant Gore on 01/02/20.
//  Copyright © 2020 Dream Big. All rights reserved.
//

import Foundation

// MARK: - Code
struct Code: Codable {
    var userName: String?
    var userImageURL: String?
    var time: String?
    var tags: [String]?
    var title, code: String?
    var codeLanguage: String?
    var upvotes, downvotes, comments: Int?

    enum CodingKeys: String, CodingKey {
        case userName = "user_name"
        case userImageURL = "user_image_url"
        case time, tags, title, code
        case codeLanguage = "code_language"
        case upvotes, downvotes, comments
    }
}
