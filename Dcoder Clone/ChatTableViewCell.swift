//
//  ChatTableViewCell.swift
//  Dcoder
//
//  Created by Surjit's iMac on 03/02/20.
//  Copyright © 2020 Surjit. All rights reserved.
//
import UIKit

class ChatTableViewCell: UITableViewCell {

    static let cellID = "chatCellID"
    let profileImageView = UIImageView()
    let messageLabel = UILabel()
    let bubbleView = UIView()
    
    var messageLeadingAnchor: NSLayoutConstraint?
    var messageTrailingAnchor: NSLayoutConstraint?
    
    var message = ""
    
    var chatMessage: Chat! {
        didSet {
            messageLabel.text = chatMessage?.text
            bubbleView.backgroundColor = chatMessage.isSentByMe ? UIColor.systemBlue : UIColor.systemTeal
            profileImageView.isHidden = chatMessage.isSentByMe
            updateAnchors()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        profileImageView.image = .checkmark
        contentView.addSubview(profileImageView)
        contentView.addSubview(bubbleView)
        contentView.addSubview(messageLabel)
        
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        bubbleView.translatesAutoresizingMaskIntoConstraints = false
        
        profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        profileImageView.layer.cornerRadius = 16
        profileImageView.clipsToBounds = true
        
        // Message Label
        messageLabel.textColor = .white
//        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24).isActive = true
        messageLeadingAnchor = messageLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 24)
        messageLeadingAnchor?.isActive = true
        messageTrailingAnchor = messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
        messageTrailingAnchor?.isActive = false
        messageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24).isActive = true
        let width = (contentView.frame.width / 5) * 4
        messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: width).isActive = true
        
        // Bubble Warp View
        bubbleView.backgroundColor = .systemBlue
        bubbleView.layer.cornerRadius = 12
        bubbleView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16).isActive = true
        bubbleView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16).isActive = true
        bubbleView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16).isActive = true
        bubbleView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16).isActive = true
        
    }
    
    func updateAnchors() {
        messageLeadingAnchor?.isActive = !chatMessage.isSentByMe
        messageTrailingAnchor?.isActive = chatMessage.isSentByMe
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

