//
//  ChatViewModel.swift
//  Dcoder Clone
//
//  Created by Hemant Gore on 03/02/20.
//  Copyright © 2020 Dream Big. All rights reserved.
//

import Foundation

class ChatViewModel {
    
    var chatMessages: [Chat] = []
    
    func getChatMessage(completionHandler: @escaping ((Bool) -> Void)) {
        let service = ServiceHandler.sharedInstance
        let endpoint = "https://dcoder.tech/test_json/chat.json"
        service.getAPIData(URLString: endpoint, objectType: [Chat].self) { [weak self] (result: CustomResult) in
            switch result {
            case .success(let object):
                self?.chatMessages = object
                completionHandler(true)
            case .failure:
                completionHandler(false)
            }
        }
    }
    
    func getChatMessage() -> [Chat] {
        return chatMessages
    }
    
    func set(message: String) {
        var chatMessage = Chat(userName: "Message", userImageURL: "", text: message)
        chatMessage.isSentByMe = true
        chatMessages.append(chatMessage)
    }
}
